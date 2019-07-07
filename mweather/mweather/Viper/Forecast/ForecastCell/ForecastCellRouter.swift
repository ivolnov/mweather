//
//  ForecastCellRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/7/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol ForecastCellRouter {
    func forecastCellAlert(_: Error)
}

extension Dependencies {
    func forecastCellRouter() -> ForecastCellRouter {
        return Router.shared
    }
}

extension Router: ForecastCellRouter {
    
    func forecastCellAlert(_ error: Error) {
        alert(error: error)
    }
    
}
