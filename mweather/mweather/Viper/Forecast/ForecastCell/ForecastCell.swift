//
//  ForecastCell.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class ForecastCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private var presenter: ForecastCellPresenter?
    
    var dependencies: ForecastCellDependencies? {
        didSet {
            if let _ = oldValue { return }
            presenter = dependencies?.forecastCellPresenter()
            presenter?.view.add(to: self)
        }
    }
    
    var city = "" {
        didSet {
            presenter?.load(for: city)
        }
    }
}
