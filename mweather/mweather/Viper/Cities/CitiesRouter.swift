//
//  CitiesRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesRouter {
    func citiesAlert(_: Error)
    func closeCities()
}

extension Dependencies {
    func citiesRouter() -> CitiesRouter {
        return Router.shared
    }
}

extension Router: CitiesRouter {
    
    func closeCities() {
        app()?
            .window?
            .rootViewController?
            .presentedViewController?
            .dismiss(animated: true)
    }
    
    func citiesAlert(_ error: Error) {
        alert(error: error)
    }
}
