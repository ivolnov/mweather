//
//  CitiesAddCellDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesAddCellDependencies {
    func citiesAddCellPresenter() -> CitiesAddCellPresenter
    func citiesAddCellRouter() -> CitiesAddCellRouter
    func citiesAddCellView() -> CitiesAddCellView
}

extension Dependencies: CitiesAddCellDependencies {
    
    func citiesAddCellDependencies() -> CitiesAddCellDependencies {
        return self
    }
}
