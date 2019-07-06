//
//  ForecastCellDependenceis.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastCellDependencies {
    func forecastCellPresenter() -> ForecastCellPresenter
    func forecastCellView() -> ForecastCellView
}


extension Dependencies: ForecastCellDependencies {}

extension Dependencies {
    func forecastCellDependencies() -> ForecastCellDependencies {
        return self
    }
}
