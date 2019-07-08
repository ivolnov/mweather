//
//  CitiesApi.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesApi {
    func search(_: String, for: CitiesApiClient)
    func forget(_: CitiesApiClient)
}

protocol CitiesApiClient {
    func citiesApiSuccess(with: CitiesApiCityModel)
    func citiesApiFailure(with: Error)
    var hash: String { get }
}

protocol CitiesApiCityModel {
    var forecasts: [CitiesApiForecastModel] { get }
    var name: String { get }
}

protocol CitiesApiForecastModel {
    var temperature: Double { get }
    var description: String { get }
    var icon: String { get }
    var date: Date { get }
}

enum ApiError: Error {
    case invalid(url: String)
    case parsing
    case noData
}

extension Dependencies {
    func citiesApi() -> CitiesApi {
        return Api.shared
    }
}

fileprivate class Api: CitiesApi {
    
    static let shared = Api()
    
    private let base = "https://api.openweathermap.org/data/2.5/forecast"
    private let apiKey = "f784d261ac97d3a8083143fd83efb876"
    
    private var clients: [String: CitiesApiClient] = [:]
    
    func search(_ query: String, for client: CitiesApiClient) {
        clients[client.hash] = client
        
        let params = [
            "units": "metric",
            "appid": apiKey,
            "q": query
        ]
        
        guard let url = self.url(base, params: params) else {
            client.citiesApiFailure(with: ApiError.invalid(url: "\(base) \(params)"))
            return
        }
        
        load(from: url) { [weak self] result in
            
            guard let consumer = self?.clients[client.hash] else {
                return
            }
            
            switch result {
                
            case .success(let data):
                let openWeatherModel = try? JSONDecoder().decode(OpenWeatherMapForecast.self, from: data)
                let apiModel = self?.convert(openWeatherModel)
                guard let model = apiModel else {
                    consumer.citiesApiFailure(with: ApiError.parsing)
                    return
                }
                
                consumer.citiesApiSuccess(with: model)
                
            case .failure(let error):
                consumer.citiesApiFailure(with: error)
            }
        }
    }
    
    func forget(_ client: CitiesApiClient) {
        clients[client.hash] = nil
    }
}

extension Api {
    
    func load(from url: URL, completion: @escaping (Result<Data, Error>) -> () ) {
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(ApiError.noData)) }
                return
            }
            
            DispatchQueue.main.async { completion(.success(data)) }
        }
        
        task.resume()
    }
    
    func url(_ value: String, params: [String: String]) -> URL? {
        var components = URLComponents(string: value)
        components?.queryItems = params.map { element in URLQueryItem(name: element.key, value: element.value) }
        
        return components?.url
    }
    
    func convert(_ model: OpenWeatherMapForecast?) -> CitiesApiCityModel? {
        
        guard let model = model else {
            return nil
        }
        
        var forecasts: [CitiesApiForecastModel] = []
        
        for index in stride(from: 0, to: model.list.count, by: 24 / 3) {
            
            guard
                let item = model.list.get(at: index),
                let weather = item.weather.first else {
                return nil
            }
            
            let date = Date(timeIntervalSince1970: item.dt)
            let description = weather.description
            let temperature = item.main.temp
            let icon =  weather.icon
            
            let forecast = ForecastModel(
                temperature: temperature,
                description: description,
                icon: icon,
                date: date)
            
            forecasts.append(forecast)
        }
        
        let city = CityModel(
            forecasts: forecasts,
            name: model.city.name)
        
        return city
    }
}


fileprivate struct CityModel: CitiesApiCityModel {
    let forecasts: [CitiesApiForecastModel]
    let name: String
}

fileprivate struct ForecastModel: CitiesApiForecastModel {
    let temperature: Double
    let description: String
    let icon: String
    let date: Date
}
