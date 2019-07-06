//
//  CitiesCell.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class CitiesCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    var dependencies: CitiesCellDependencies? {
        didSet {
            if let _ = oldValue { return }
            view = dependencies?.citiesCellView()
            view?.attach(to: self)
        }
    }
    
    var model: CitiesCellViewModel? {
        didSet {
            if let model = model {
                view?.set(model: model)
            }
        }
    }
    
    private var view: CitiesCellView?
}
