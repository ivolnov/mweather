//
//  SearchInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol SearchInteractor {
    func save(forecasts: [SearchInteractorForecastModel], completion: @escaping (Result<Void, Error>) -> ())
    func search(city: String, completion: @escaping (Result<[SearchInteractorForecastModel], Error>) -> ())
}

protocol SearchInteractorForecastModel {
    var temperature: Double { get }
    var weather: String  { get }
    var city: String  { get }
    var icon: String  { get }
    var date: Date  { get }
}

extension Dependencies {
    func searchInteractor() -> SearchInteractor {
        return Interactor(dependencies: self)
    }
}

fileprivate class Interactor: SearchInteractor {
    
    var hash: String = "SearchInteractor"
    
    private var searchCompletion: ((Result<[SearchInteractorForecastModel], Error>) -> ())?
    private var saveCompletion: ((Result<Void, Error>) -> ())?
    private var city: City?
    
    private let repository: CitiesRepository
    private let api: CitiesApi
    
    init(dependencies: ForecastCellDependencies) {
        repository = dependencies.citiesRepository()
        api = dependencies.citiesApi()
    }
    
    func search(city: String, completion: @escaping
        (Result<[SearchInteractorForecastModel], Error>) -> ()) {
        searchCompletion = completion
        api.forget(self) // TODO: not working
        api.search(city, for: self)
    }
    
    func save(forecasts: [SearchInteractorForecastModel], completion: @escaping (Result<Void, Error>) -> ()) {
        saveCompletion = completion
        let city = convert(forecasts: forecasts)
        self.city = city
        repository.add(listener: self)
        repository.put(city: city)
    }
    
    private func convert(forecasts: [SearchInteractorForecastModel]) -> City {
        let name = forecasts.first?.city ?? ""
        let week = forecasts
            .map {  Forecast(temperature: $0.temperature,
                             weather: $0.weather,
                             icon: $0.icon,
                             date: $0.date
                )}
        return City(chosen: false, name: name, created: Date(), week: week)
    }
}

extension Interactor: CitiesRepositoryListener {
    
    func citiesRepositoryFailure(with error: Error) {
        saveCompletion?(.failure(error))
    }
    
    func current(cities: [City]) {
        
        guard let city = city else {
            return
        }
        
        let noRecord = cities
            .filter { $0.name == city.name }
            .isEmpty
        
        if !noRecord {
            saveCompletion?(.success(()))
        }
    }
}

extension Interactor: CitiesApiClient {
    
    func success(with model: CitiesApiCityModel) {
        let forecasts = convert(model: model)
        searchCompletion?(.success(forecasts))
    }
    
    func citiesApiFailure(with error: Error) {
        searchCompletion?(.failure(error))
    }
    
    private func convert(model: CitiesApiCityModel) -> [SearchInteractorForecastModel] {
        let forecasts = model.forecasts
            .map {  Model(temperature: $0.temperature,
                          weather: $0.description,
                          city: model.name,
                          icon: $0.icon,
                          date: $0.date
                )}
        return forecasts
    }
}

fileprivate struct Model: SearchInteractorForecastModel {
    
    let temperature: Double
    let weather: String
    let city: String
    let icon: String
    let date: Date
}
