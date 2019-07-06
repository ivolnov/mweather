//
//  ForecastView.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

protocol ForecastView {
    var presenter: ForecastPresenter? { get set }
    func add(to: UIView)
}

extension Dependencies {
    func forecastView() -> ForecastView {
        return View()
    }
}


fileprivate class View: ForecastView {
    
    weak var presenter: ForecastPresenter?
    
    func add(to root: UIView) {
        root.backgroundColor = .red
    }
}
