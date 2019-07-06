//
//  CitiesPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol CitiesPresenter: class {
    var view: CitiesView { get }
    func cities() -> [CitiesPresenterModel]
    func select(at: Int)
    func refresh()
}

protocol CitiesPresenterModel {
    var temperature: String { get }
    var city: String { get }
}

extension Dependencies {
    func citiesPresenter() -> CitiesPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: CitiesPresenter {
   
    private let router: CitiesRouter
    var view: CitiesView
    
    init(dependencies: CitiesDependencies) {
        router = dependencies.citiesRouter()
        view = dependencies.citiesView()
        view.presenter = self
    }
    
    func cities() -> [CitiesPresenterModel] {
        return hardcode
    }
    
    func select(at position: Int) {
        // TODO: save choice
        router.dismiss()
    }
    
    func refresh() {
        view.reload()
        view.hideRefreshControl()
    }
}

fileprivate struct Model: CitiesPresenterModel {
    let temperature: String
    let city: String
}

fileprivate let hardcode = [
    Model(temperature: "20º", city: "Moscow"),
    Model(temperature: "20º", city: "Paris"),
    Model(temperature: "20º", city: "New York"),
    Model(temperature: "20º", city: "Loas Angeles"),
    Model(temperature: "20º", city: "Taumatawhakatangihangakoauauotamateapokaiwhenuakitanatahu")
]
