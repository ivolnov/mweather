//
//  Forecast.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

struct Forecast {
    
    enum Weather {
        case sunny
        case rainy
    }
    
    let temperature: Int
    let weather: Weather
    let date: Date
}
