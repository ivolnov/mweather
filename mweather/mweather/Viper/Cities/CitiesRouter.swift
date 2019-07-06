//
//  CitiesRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesRouter {
    
}

extension Dependencies {
    func citiesRouter() -> CitiesRouter {
        return Router.shared
    }
}

extension Router: CitiesRouter {}
