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
}


extension Dependencies {
    func searchPresenter() -> SearchPresenter {
        return Presenter(dependencies: self)
    }
}


fileprivate class Presenter: SearchPresenter {
    
    var view: SearchView
    
    init(dependencies: SearchDependencies) {
        view = dependencies.searchView()
        view.presenter = self
    }
}
