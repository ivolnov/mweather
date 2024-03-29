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
        
        view.show(activity: true)
        
        interactor.cities { [weak self] result in
            
            guard let strong = self else {
                return
            }

            switch result {
            case .success(let models):
                
                strong.models = models
                strong.view.reload()

                if let chosen = strong.chosen(in: models) {
                    strong.view.choose(at: chosen)
                }

            case .failure(let error):
                strong.router.forecastAlert(error)
            }

            self?.view.show(activity: false)
        }
    }
    
    private func chosen(in models: [ForecastInteractorCityModel]) -> Int? {
        let row = models
            .enumerated()
            .filter { $0.element.chosen }
            .map { $0.offset}
            .first
        return row
    }
}
