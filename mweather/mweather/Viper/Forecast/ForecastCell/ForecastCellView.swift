//
//  ForecastCellView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit

protocol ForecastCellView {
    
    func set(model: ForecastCellModel)
    func add(to: UIView)
}

protocol ForecastCellModel {
    
}

extension Dependencies {
    func forecastCellView() -> ForecastCellView {
        return View()
    }
}


fileprivate class View: ForecastCellView {
    
    func set(model: ForecastCellModel) {
        
    }
    
    func add(to root: UIView) {
        root.backgroundColor = UIColor.random()
    }
}
