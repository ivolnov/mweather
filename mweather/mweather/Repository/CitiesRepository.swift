//
//  CitiesRepository.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesRepository {
    func add(listener: CitiesRepositoryListener)
    func delete(city: String)
    func choose(city: String)
    func put(city: City)
}

protocol CitiesRepositoryListener: class {
    func citiesRepositoryFailure(with: Error)
    func current(cities: [City])
    var hash: String { get }
}
