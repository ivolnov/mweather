//
//  CitiesDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesDependencies {
    func citiesAddCellDependencies() -> CitiesAddCellDependencies
    func citiesCellDependencies() -> CitiesCellDependencies
    func citiesInteractor() -> CitiesInteractor
    func citiesPresenter() -> CitiesPresenter
    func citiesRouter() -> CitiesRouter
    func citiesView() -> CitiesView
}


extension Dependencies: CitiesDependencies {
    
}
