//
//  ForecastPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastPresenter: class {
    
    var view: ForecastView { get }
    func cities() -> [String]
    func openCities()
}

extension Dependencies {
    func forecastPresenter() -> ForecastPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: ForecastPresenter {
    
    private var models: [ForecastInteractorCityModel] = []
    
    private let interactor: ForecastInteractor
    private let router: ForecastRouter
    
    var view: ForecastView
    
    init(dependencies: ForecastDependencies) {
        interactor = dependencies.forecastInteractor()
        router = dependencies.forecastRouter()
        view = dependencies.forecastView()
        view.presenter = self
    }
    
    func cities() -> [String] {
        
        if models.isEmpty {
            load()
        }
        
        let names = models.map { $0.name }
        return names
    }
    
    func openCities() {
        router.openCities()
    }
    
    private func load() {
        interactor.cities { [weak self] result in
            
            switch result {
            case .success(let models):
                self?.models = models
                self?.view.reload()
            case .failure(let error):
                self?.router.forecastAlert(error)
            }
        }
    }
}
