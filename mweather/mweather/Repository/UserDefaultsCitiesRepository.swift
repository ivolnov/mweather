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
    
    func choose(city: String) {
        let old = read()
        if let chosen = old[city] {
            var cities: [String: City] = [:]
            for city in old.values {
                cities[city.name] = city.name == chosen.name
                    ? copy(city, chosen: true)
                    : copy(city, chosen: false)
            }
            write(cities)
            notifyAll(with: cities)
        }
 
    }
    
    func put(city: City) {
        var cities = read()
        var city = city
        if let current = cities[city.name] {
            city = mergeDate(from: current, to: city)
        }
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
    
    private func mergeDate(from old: City, to new: City) -> City {
        let city = City(chosen: false,
                        name: new.name,
                        created: old.created,
                        week: new.week)
        return city
    }
    
    private func copy(_ old: City, chosen: Bool) -> City {
        let city = City(chosen: chosen,
                        name: old.name,
                        created: old.created,
                        week: old .week)
        return city
    }
}
