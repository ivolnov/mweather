//
//  ForecastCellDependenceis.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastCellDependencies: SharedDependencies {
    func forecastCellInteractor() -> ForecastCellInteractor
    func forecastCellPresenter() -> ForecastCellPresenter
    func forecastCellRouter() -> ForecastCellRouter
    func forecastCellView() -> ForecastCellView
}


extension Dependencies: ForecastCellDependencies {
    func forecastCellDependencies() -> ForecastCellDependencies {
        return self
    }
}
