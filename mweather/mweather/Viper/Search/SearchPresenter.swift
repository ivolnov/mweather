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
    
    private var forecasts: [SearchInteractorForecastModel]?
    private let interactor: SearchInteractor
    private let router: SearchRouter
    
    var view: SearchView
    
    init(dependencies: SearchDependencies) {
        interactor = dependencies.searchInteractor()
        router = dependencies.searchRouter()
        view = dependencies.searchView()
        view.presenter = self
    }
    
    func search(city: String) {
        
        view.show(activity: true)
        
        interactor.search(city: city) { [weak self] result in
            
            switch result {
            case .success(let forecasts):
                if let strong = self, let model = strong.convert(forecasts) {
                    strong.forecasts = forecasts
                    strong.view.set(city: model)
                }
                
            case .failure(let error):
                switch error {
                case ApiError.parsing:
                    ()
                default:
                    self?.router.searchAlert(error)
                }
            }
            
            self?.view.show(activity: false)
        }
    }
    
    func cancel() {
        view.show(keybord: false)
        router.closeSearch()
    }
    
    func add() {
        if let forecasts = forecasts {
            interactor.save(forecasts: forecasts)
            view.show(keybord: false)
            router.closeSearch()
        }
    
    }
    
    private func convert(_ forecasts: [SearchInteractorForecastModel]) -> SearchViewCityModel? {
        
        guard let forecast = forecasts.first else  {
            return nil
        }
       
        let weather = forecast.weather.capitalizeFirstLetter()
        let name = forecast.city.capitalizeFirstLetter()
        let temperature = "\(forecast.temperature)º"
        
        return Model(temperature: temperature, weather: weather, name: name)
    }
}


fileprivate struct Model: SearchViewCityModel {
    var temperature: String
    var weather: String
    var name: String
}
