//
//  ForecastDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastDependencies {
    func forecastCellDependencies() -> ForecastCellDependencies
    func forecastInteractor() -> ForecastInteractor
    func forecastPresenter() -> ForecastPresenter
    func forecastRouter() -> ForecastRouter
    func forecastView() -> ForecastView
}

extension Dependencies: ForecastDependencies {}
