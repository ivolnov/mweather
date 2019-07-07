//
//  ApiFiveDayForecastModel.swift
//  mweather
//
//  Created by ivan volnov on 7/7/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

struct OpenWeatherMapForecast: Codable {
    let list: [OpenWeatherMapThreeHourListItem]
    let city: OpenWeatherMapCity
}

struct OpenWeatherMapCity: Codable {
    let name: String
}

struct OpenWeatherMapThreeHourListItem: Codable {
    
    let weather: [OpenWeatherMapWeather]
    let main: OpenWeatherMapMain
    let dt: Double
}

struct OpenWeatherMapMain: Codable {
    let temp: Double
}

struct OpenWeatherMapWeather: Codable {
    let description: String
    let icon: String
}
