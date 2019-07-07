//
//  SearchPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol SearchPresenter: class {
    var view: SearchView { get }
    func search(city: String)
    func cancel()
    func add()
}


extension Dependencies {
    func searchPresenter() -> SearchPresenter {
        return Presenter(dependencies: self)
    }
}


fileprivate class Presenter: SearchPresenter {
    
    private let router: SearchRouter
    var view: SearchView
    
    init(dependencies: SearchDependencies) {
        router = dependencies.searchRouter()
        view = dependencies.searchView()
        view.presenter = self
    }
    
    func search(city: String) {
        view.show(activity: true)
        let model = Model(temperature: "20º", weather: "partially cloudy", name: "Moscow")
        view.show(activity: false)
        view.set(city: model)
    }
    
    func cancel() {
        view.show(keybord: false)
        router.closeSearch()
    }
    
    func add() {
        view.show(keybord: false)
        router.closeSearch()
    }
}


fileprivate struct Model: SearchViewCityModel {
    var temperature: String
    
    var weather: String
    
    var name: String
    
    
}
