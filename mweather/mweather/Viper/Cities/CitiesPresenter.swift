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
    func delete(at: Int)
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
    
    private var models: [CitiesInteractorCityModel]?
    private let interactor: CitiesInteractor
    private let router: CitiesRouter
    var view: CitiesView
    
    init(dependencies: CitiesDependencies) {
        interactor = dependencies.citiesInteractor()
        router = dependencies.citiesRouter()
        view = dependencies.citiesView()
        view.presenter = self
    }
    
    func cities() -> [CitiesPresenterModel] {
        
        if models == nil {
            load()
        }
        
        let cities = models?.map { convert($0) }
        return cities ?? []
    }
    
    func select(at position: Int) {
        
        guard let models = models else {
            return
        }
        
        if position == models.count {
            return
        }
        
        if let model = models.get(at: position) {
            interactor.choose(model)
            router.closeCities()
        }
    }
    
    func delete(at position: Int) {
        if let model = models?.get(at: position) {
            interactor.remove(model)
        }
    }
    
    func refresh() {
        view.reload()
        view.hideRefreshControl()
    }
    
    private func load() {
        interactor.cities { [weak self] result in
            
            switch result {
            case .success(let models):
                self?.models = models
                self?.view.reload()
            case .failure(let error):
                self?.router.citiesAlert(error)
            }
        }
    }
    
    private func convert(_ model: CitiesInteractorCityModel) -> CitiesPresenterModel {
        let temperature = "\(Int(model.temperature))º"
        let city = model.name.capitalizeFirstLetter()
        return Model(temperature: temperature, city: city)
    }
}

fileprivate struct Model: CitiesPresenterModel {
    let temperature: String
    let city: String
}
