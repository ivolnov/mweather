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
}

extension Dependencies {
    func forecastPresenter() -> ForecastPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: ForecastPresenter {
    
    var view: ForecastView
    
    init(dependencies: ForecastDependencies) {
        view = dependencies.forecastView()
        view.presenter = self
    }
    
}
