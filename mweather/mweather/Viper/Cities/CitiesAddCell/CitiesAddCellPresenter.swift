//
//  CitiesAddCellPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesAddCellPresenter: class {
    var view: CitiesAddCellView { get }
    func add()
}


extension Dependencies {
    func citiesAddCellPresenter() -> CitiesAddCellPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: CitiesAddCellPresenter {
    
    private let router: CitiesAddCellRouter
    var view: CitiesAddCellView
    
    
    init(dependencies: CitiesAddCellDependencies) {
        router = dependencies.citiesAddCellRouter()
        view = dependencies.citiesAddCellView()
        view.presenter = self
    }
    
    func add() {
        router.showSearch()
    }
}


fileprivate struct Model: ForecastCellViewModel {
    var icon: ForecastCellViewModelIcon
    let temperature: String
    let weather: String
    let city: String
    let day: String
}
