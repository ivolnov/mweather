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
}


extension Dependencies {
    func citiesPresenter() -> CitiesPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: CitiesPresenter {
    
    var view: CitiesView
    
    init(dependencies: CitiesDependencies) {
        view = dependencies.citiesView()
        view.presenter = self
    }
}

