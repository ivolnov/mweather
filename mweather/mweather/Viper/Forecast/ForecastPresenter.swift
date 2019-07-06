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
    
    private let router: ForecastRouter
    
    var view: ForecastView
    
    init(dependencies: ForecastDependencies) {
        router = dependencies.forecastRouter()
        view = dependencies.forecastView()
        view.presenter = self
    }
    
    func cities() -> [String] {
        return ["", "", ""]
    }
    
    func openCities() {
        router.openCities()
    }
}

