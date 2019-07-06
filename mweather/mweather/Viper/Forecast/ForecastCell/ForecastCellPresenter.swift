//
//  ForecastCellPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastCellPresenter: class {
    var view: ForecastCellView { get }
    func refresh(for city: String)
    func load(for city: String)
}


extension Dependencies {
    func forecastCellPresenter() -> ForecastCellPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: ForecastCellPresenter {
    
    var view: ForecastCellView
    
    init(dependencies: ForecastCellDependencies) {
        view = dependencies.forecastCellView()
        view.presenter = self
    }
    
    func refresh(for city: String) {
        view.set(days: hardcode)
        view.hideRefreshControl()
    }
    
    func load(for city: String) {
        view.set(days: hardcode)
    }
}


fileprivate struct Model: ForecastCellViewModel {
    var icon: ForecastCellViewModelIcon
    let temperature: String
    let weather: String
    let city: String
    let day: String
}

fileprivate let hardcode: [ForecastCellViewModel] = [
    Model(icon: .rain, temperature: "20º", weather: "rain", city: "London", day: "Tuesday"),
    Model(icon: .clearSky, temperature: "30º", weather: "sunny", city: "London", day: "Wednesday"),
    Model(icon: .clearSky, temperature: "30º", weather: "sunny", city: "London", day: "Thursday"),
    Model(icon: .clearSky, temperature: "30º", weather: "sunny", city: "London", day: "Friday"),
    Model(icon: .clearSky, temperature: "30º", weather: "sunny", city: "London", day: "Saturday")
]
