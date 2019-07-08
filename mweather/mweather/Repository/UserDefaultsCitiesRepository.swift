//
//  UserDefaultsRepository.swift
//  mweather
//
//  Created by ivan volnov on 7/8/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

extension Dependencies {
    func citiesRepository() -> CitiesRepository {
        return UserDefaultsCitiesRepository.shared
    }
}

fileprivate class UserDefaultsCitiesRepository: CitiesRepository {
    
    static let shared = UserDefaultsCitiesRepository()
    
    private var listeners: [String: CitiesRepositoryListener] = [:]
    
    func add(listener: CitiesRepositoryListener) {
        listeners[listener.hash] = listener
        let cities = read()
        notify(listener, with: cities)
    }
    
    func delete(city: String) {
        var cities = read()
        cities[city] = nil
        write(cities)
        notifyAll(with: cities)
    }
    
    func put(city: City) {
        var cities = read()
        cities[city.name] = city
        write(cities)
        notifyAll(with: cities)
    }
    
    private func read() -> [String: City] {
        
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "UserDefaultsCitiesRepository") as? Data else {
            return [:]
        }
        
        let decoder = JSONDecoder()
        guard let cities = try? decoder.decode([String: City].self, from: data) else {
            return [:]
        }
        
        return cities
    }
    
    private func write(_ cities: [String: City]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cities) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "UserDefaultsCitiesRepository")
        }
    }
    
    private func notify(_ listener: CitiesRepositoryListener, with cities: [String: City]) {
        let copy = cities
            .map { $0.value }
            .sorted { $0.created < $1.created }
        listener.current(cities: copy)
    }
    
    private func notifyAll(with cities: [String: City]) {
        for listener in listeners.values {
            notify(listener, with: cities)
        }
    }
}
