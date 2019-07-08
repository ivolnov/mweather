//
//  City.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

struct City: Codable {
    let name: String
    let created: Date
    let week: [Forecast]
}
