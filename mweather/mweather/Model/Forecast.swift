//
//  Forecast.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let temperature: Double
    let weather: String
    let icon: String
    let date: Date
}
