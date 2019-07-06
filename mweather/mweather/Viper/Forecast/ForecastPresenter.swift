//
//  ForecastPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastPresenter: class {
    func cities() -> [ForecastPresenterCityModel]
    var view: ForecastView { get }
    func openCities()
}

protocol ForecastPresenterCityModel {
   
}

extension Dependencies {
    func forecastPresenter() -> ForecastPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: ForecastPresenter {
    
    private let router: ForecastRouter
    
    var view: ForecastView
    
    init(dependencies: ForecastDependencies) {
        router = dependencies.forecastRouter()
        view = dependencies.forecastView()
        view.presenter = self
    }
    
    func cities() -> [ForecastPresenterCityModel] {
        return [Model(), Model(), Model()]
    }
    
    func openCities() {
        router.openCities()
    }
}

fileprivate struct Model: ForecastPresenterCityModel {}
