//
//  ForecastInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastInteractor {
    func cities(completion: @escaping (Result<[ForecastInteractorCityModel], Error>) -> ())
}

protocol ForecastInteractorCityModel {
    var name: String { get }
}

extension Dependencies {
    func forecastInteractor() -> ForecastInteractor {
        return Interactor(dependencies: self)
    }
}

fileprivate class Interactor: ForecastInteractor {
    
    var hash: String = "ForecastInteractor"
    
    private var completion: ((Result<[ForecastInteractorCityModel], Error>) -> ())?
    private var coldStart = true
    
    private let repository: CitiesRepository
    private let api: CitiesApi
    
    init(dependencies: ForecastDependencies) {
        repository = dependencies.citiesRepository()
        api = dependencies.citiesApi()
    }
    
    deinit {
        repository.remove(listener: self)
        api.forget(self)
    }
    
    func cities(completion: @escaping (Result<[ForecastInteractorCityModel], Error>) -> ()) {
        self.completion = completion
        repository.add(listener: self)
    }
    
    func failure(with error: Error) {
        completion?(.failure(error))
    }
}

extension Interactor: CitiesRepositoryListener {
    
    func current(cities: [City]) {
        
        if coldStart {
            coldStart = false
            let queries = cities.isEmpty
                ? defaults
                : cities.map { $0.name }
            
            for query in queries {
                api.search(query, for: self)
            }
        }
        
        
        let models = cities.map { convert($0) }
        completion?(.success(models))
    }
    
    private func convert(_ city: City) -> ForecastInteractorCityModel {
        let model = Model(name: city.name)
        return model
    }
}

extension Interactor: CitiesApiClient {
    
    func success(with model: CitiesApiCityModel) {
        let city = convert(model)
        repository.put(city: city)
    }
    
    private func convert(_ model: CitiesApiCityModel) -> City {
        let name = model.name
        let week = model.forecasts
            .map {  Forecast(temperature: $0.temperature,
                             weather: $0.description,
                             icon: $0.icon,
                             date: $0.date
                )}
        return City(name: name, week: week)
    }
}

fileprivate struct Model: ForecastInteractorCityModel {
    let name: String
}

fileprivate let defaults = [
    "Ulyanovsk",
    "New York",
    "Los Angeles"
]
