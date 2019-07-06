//
//  ForecastCellViewModelIcon.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

enum ForecastCellViewModelIcon: String {
    
    case clearSkyNight = "01n"
    case fewCloudsNight  = "02n"
    case scatteredCloudsNight  = "03n"
    case brokenCloudsNight  = "04n"
    case showerRainNight  = "09n"
    case rainNight  = "10n"
    case thunderstormNight  = "11n"
    case snowNight  = "13n"
    case mistNight  = "50n"
    
    case clearSky = "01d"
    case fewClouds = "02d"
    case scatteredClouds = "03d"
    case brokenClouds = "04d"
    case showerRain = "09d"
    case rain = "10d"
    case thunderstorm = "11d"
    case snow = "13d"
    case mist = "50d"
    
    func image() -> UIImage {
        switch self {
        case .clearSkyNight:
            return #imageLiteral(resourceName: "01n")
        case .fewCloudsNight:
            return #imageLiteral(resourceName: "02n")
        case .scatteredCloudsNight:
            return #imageLiteral(resourceName: "02n")
        case .brokenCloudsNight:
            return #imageLiteral(resourceName: "04n")
        case .showerRainNight:
            return #imageLiteral(resourceName: "09d")
        case .rainNight:
            return #imageLiteral(resourceName: "10n")
        case .thunderstormNight:
            return #imageLiteral(resourceName: "11n")
        case .snowNight:
            return #imageLiteral(resourceName: "13n")
        case .mistNight:
            return #imageLiteral(resourceName: "50n")
            
        case .clearSky:
            return #imageLiteral(resourceName: "01d")
        case .fewClouds:
            return #imageLiteral(resourceName: "02d")
        case .scatteredClouds:
            return #imageLiteral(resourceName: "03d")
        case .brokenClouds:
            return #imageLiteral(resourceName: "04d")
        case .showerRain:
            return #imageLiteral(resourceName: "09n")
        case .rain:
            return #imageLiteral(resourceName: "10d")
        case .thunderstorm:
            return #imageLiteral(resourceName: "11d")
        case .snow:
            return #imageLiteral(resourceName: "13d")
        case .mist:
            return #imageLiteral(resourceName: "50d")
        }
    }
}
