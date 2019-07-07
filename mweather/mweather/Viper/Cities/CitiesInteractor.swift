//
//  CitiesInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesInteractor {
    func cities(completion: @escaping (Result<[CitiesInteractorCityModel], Error>) -> ())
}

protocol CitiesInteractorCityModel {
    var name: String { get }
    var temperature: Double { get }
}

extension Dependencies {
    func citiesInteractor() -> CitiesInteractor {
        return Interactor(dependencies: self)
    }
}

fileprivate class Interactor: CitiesInteractor {
    
    var hash: String = "CitiesInteractor"
    
    private var completion: ((Result<[CitiesInteractorCityModel], Error>) -> ())?
    private var coldStart = true
    
    private let repository: CitiesRepository
    private let api: CitiesApi
    
    init(dependencies: CitiesDependencies) {
        repository = dependencies.citiesRepository()
        api = dependencies.citiesApi()
    }
    
    deinit {
        repository.remove(listener: self)
        api.forget(self)
    }
    
    func cities(completion: @escaping (Result<[CitiesInteractorCityModel], Error>) -> ()) {
        self.completion = completion
        repository.add(listener: self)
    }
    
    func failure(with error: Error) {
        completion?(.failure(error))
    }
}

extension Interactor: CitiesRepositoryListener {
    
    func current(cities: [City]) {
        
        let models = cities.map { convert($0) }
        completion?(.success(models))
    }
    
    private func convert(_ city: City) -> CitiesInteractorCityModel {
        let temperature = city.week.first?.temperature ?? 0
        let name = city.name
        let model = Model(temperature: temperature, name: name)
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
        return City(name: name, created: Date(), week: week)
    }
}

fileprivate struct Model: CitiesInteractorCityModel {
    var temperature: Double
    let name: String
}
