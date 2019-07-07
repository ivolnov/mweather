//
//  ForecastCellPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol ForecastCellPresenter: class {
    var view: ForecastCellView { get }
    func refresh(for city: String)
    func load(for city: String)
}


extension Dependencies {
    func forecastCellPresenter() -> ForecastCellPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: ForecastCellPresenter {
    private let interactor: ForecastCellInteractor
    private let router: ForecastCellRouter
    var view: ForecastCellView
    
    init(dependencies: ForecastCellDependencies) {
        interactor = dependencies.forecastCellInteractor()
        router = dependencies.forecastCellRouter()
        view = dependencies.forecastCellView()
        view.presenter = self
    }
    
    func refresh(for city: String) {
        
        view.hideRefreshControl()
    }
    
    func load(for city: String) {
        
        interactor.city(named: city) { [weak self] result in

            switch result {
            case .success(let models):
                if let strong = self {
                    let days = models.map { strong.convert($0) }
                    strong.view.set(days: days)
                }
            case .failure(let error):
                self?.router.forecastCellAlert(error)
            }
        }
    }
    
    private func convert(_ model: ForecastCellInteractorForecastModel) -> ForecastCellViewModel {
        let icon = ForecastCellViewModelIcon(rawValue: model.icon) ?? .clearSky
        let temperature = "\(Int(model.temperature))º"
        let weather = model.weather.capitalizeFirstLetter()
        let city = model.city.capitalizeFirstLetter()
        let day = model.date.dayOfWeek() ?? ""
        return Model(icon: icon,
                     temperature: temperature,
                     weather: weather,
                     city: city,
                     day: day)
    }
}

fileprivate struct Model: ForecastCellViewModel {
    var icon: ForecastCellViewModelIcon
    let temperature: String
    let weather: String
    let city: String
    let day: String
}
