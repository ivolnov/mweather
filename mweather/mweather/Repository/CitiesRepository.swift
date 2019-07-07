//
//  CitiesRepository.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesRepository {
    func remove(listener: CitiesRepositoryListener)
    func add(listener: CitiesRepositoryListener)
    func delete(city: String)
    func put(city: City)
}

protocol CitiesRepositoryListener: class {
    func current(cities: [City])
    func failure(with: Error)
    var hash: String { get }
}

extension Dependencies {
    func citiesRepository() -> CitiesRepository {
        return RamRepository.shared
    }
}

fileprivate class RamRepository: CitiesRepository {
    
    static let shared = RamRepository()
    
    private var listeners: [String: CitiesRepositoryListener] = [:]
    private var cities: [City] = []
    
    func remove(listener: CitiesRepositoryListener) {
        listeners[listener.hash] = nil
    }
    
    func add(listener: CitiesRepositoryListener) {
        listeners[listener.hash] = listener
        notify(listener)
    }
    
    func delete(city: String) {
        cities = cities.filter { $0.name != city }
        notifyAll()
    }
    
    func put(city: City) {
        cities.append(city)
        notifyAll()
    }
    
    private func notify(_ listener: CitiesRepositoryListener) {
        let copy = cities.map { $0 }
        listener.current(cities: copy)
    }
    
    private func notifyAll() {
        for listener in listeners.values {
            notify(listener)
        }
    }
}
