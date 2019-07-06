//
//  CitiesView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit

protocol CitiesView {
    var presenter: CitiesPresenter? { get set }
    func add(to: UIView)
}


extension Dependencies {
    func citiesView() -> CitiesView {
        return View()
    }
}


fileprivate class View: CitiesView {
    weak var presenter: CitiesPresenter?
    
    func add(to: UIView) {
        
    }
}

