//
//  ForecastRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol ForecastRouter {
    
}

extension Dependencies {
    func forecastRouter() -> ForecastRouter {
        return Router.shared
    }
}

extension Router: ForecastRouter {
    
}
