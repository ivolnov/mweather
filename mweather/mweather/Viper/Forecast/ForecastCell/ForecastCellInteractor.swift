//
//  ForecastCellInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/7/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastCellInteractor {
    func city(named: String, completion: @escaping (Result<[ForecastCellInteractorForecastModel], Error>) -> ())
    func refresh(city: String)
}

protocol ForecastCellInteractorForecastModel {
    var temperature: Double { get }
    var weather: String  { get }
    var city: String  { get }
    var icon: String  { get }
    var date: Date  { get }
}

extension Dependencies {
    func forecastCellInteractor() -> ForecastCellInteractor {
        return Interactor(dependencies: self)
    }
}

fileprivate class Interactor: ForecastCellInteractor {
    
    var hash: String = "ForecastCellInteractor"
    
    private var completion: ((Result<[ForecastCellInteractorForecastModel], Error>) -> ())?
    private var city: String?
    
    private let repository: CitiesRepository
    private let api: CitiesApi
    
    init(dependencies: ForecastCellDependencies) {
        repository = dependencies.citiesRepository()
        api = dependencies.citiesApi()
    }
    
    func city(named: String, completion: @escaping
        (Result<[ForecastCellInteractorForecastModel], Error>) -> ()) {
        self.completion = completion
        self.city = named
        repository.add(listener: self)
    }
    
    func refresh(city: String) {
        api.search(city, for: self)
    }
}

extension Interactor: CitiesRepositoryListener {
    
    func citiesRepositoryFailure(with error: Error) {
        completion?(.failure(error))
    }
    
    func current(cities: [City]) {
        for model in cities {
            if model.name == city {
                let interactorModel = convert(model)
                completion?(.success(interactorModel))
            }
        }
    }
    
    private func convert(_ city: City) -> [ForecastCellInteractorForecastModel] {
        
        var models: [ForecastCellInteractorForecastModel] = []
        
        for forecast in city.week {
            let model = Model(temperature: forecast.temperature,
                              weather: forecast.weather,
                              city: city.name,
                              icon: forecast.icon,
                              date: forecast.date)
            models.append(model)
        }
        
        return models
    }
}

extension Interactor: CitiesApiClient {
    
    func citiesApiSuccess(with model: CitiesApiCityModel) {
        let city = convert(model)
        repository.put(city: city)
    }
    
    func citiesApiFailure(with error: Error) {
        completion?(.failure(error))
    }
    
    private func convert(_ model: CitiesApiCityModel) -> City {
        let name = model.name
        let week = model.forecasts
            .map {  Forecast(temperature: $0.temperature,
                             weather: $0.description,
                             icon: $0.icon,
                             date: $0.date
                )}
        return City(chosen: false, name: name, created: Date(), week: week)
    }
}

fileprivate struct Model: ForecastCellInteractorForecastModel {
    
    let temperature: Double
    let weather: String
    let city: String
    let icon: String
    let date: Date
}
