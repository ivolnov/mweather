//
//  MainPresenter.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol MainPresenter {
    var view: MainView { get }
}

extension Dependencies {
    func mainPresenter() -> MainPresenter {
        return Presenter(dependencies: self)
    }
}

fileprivate class Presenter: MainPresenter {
    
    
    let view: MainView
    
    init(dependencies: MainDependencies) {
        view = dependencies.mainView()
    }
    
}
