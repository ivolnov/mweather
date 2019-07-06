//
//  ForecastInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastInteractor {
    
}

extension Dependencies {
    func forecastInteractor() -> ForecastInteractor {
        return Interactor()
    }
}


fileprivate class Interactor: ForecastInteractor {
    
}
