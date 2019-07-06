//
//  SearchDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol SearchDependencies {
    func searchInteractor() -> SearchInteractor
    func searchPresenter() -> SearchPresenter
    func searchRouter() -> SearchRouter
    func searchView() -> SearchView
}


extension Dependencies: SearchDependencies {
}
