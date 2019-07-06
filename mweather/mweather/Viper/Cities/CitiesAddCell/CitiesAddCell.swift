//
//  CitiesAddCell.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class CitiesAddCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private var presenter: CitiesAddCellPresenter?
    
    var dependencies: CitiesAddCellDependencies? {
        didSet {
            if let _ = oldValue { return }
            presenter = dependencies?.citiesAddCellPresenter()
            presenter?.view.add(to: self)
        }
    }
}
