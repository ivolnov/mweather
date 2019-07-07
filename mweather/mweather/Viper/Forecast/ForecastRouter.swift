//
//  ForecastRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol ForecastRouter {
    func forecastAlert(_: Error)
    func openCities()
}

extension Dependencies {
    func forecastRouter() -> ForecastRouter {
        return Router.shared
    }
}

extension Router: ForecastRouter {
    
    func openCities() {
        let vc = CitiesViewController(dependencies: Dependencies.shared)
        app()?
            .window?
            .rootViewController?
            .present(vc, animated: true)
    }
    
    func forecastAlert(_ error: Error) {
        alert(error: error)
    }
    
}
