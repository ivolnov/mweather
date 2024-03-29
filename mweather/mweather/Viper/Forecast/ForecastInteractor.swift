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
    var chosen: Bool { get }
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
    
    func cities(completion: @escaping (Result<[ForecastInteractorCityModel], Error>) -> ()) {
        self.completion = completion
        repository.add(listener: self)
    }
}

extension Interactor: CitiesRepositoryListener {
    
    func citiesRepositoryFailure(with error: Error) {
        completion?(.failure(error))
    }
    
    func current(cities: [City]) {
        
        if coldStart {
            coldStart = false
            let queries = cities.isEmpty
                ? AppDelegate.defaults
                : cities.map { $0.name }
            
            for query in queries {
                api.search(query, for: self)
            }
        }
        
        
        let models = cities.map { convert($0) }
        let result = models.isEmpty
            ? [Model(chosen: true, name: "noop")]
            : models
        
        completion?(.success(result))
    }
    
    private func convert(_ city: City) -> ForecastInteractorCityModel {
        let model = Model(chosen: city.chosen, name: city.name)
        return model
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

fileprivate struct Model: ForecastInteractorCityModel {
    let chosen: Bool
    let name: String
}
