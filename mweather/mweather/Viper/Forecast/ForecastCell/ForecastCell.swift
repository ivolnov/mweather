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
    
    var dependencies: ForecastCellDependencies? {
        didSet {
            if let _ = oldValue { return }
            view = dependencies?.forecastCellView()
            view?.add(to: self)
        }
    }
    
    private var view: ForecastCellView?
}
