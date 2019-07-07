//
//  SearchRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol SearchRouter {
    func closeSearch()
}

extension Dependencies {
    func searchRouter() -> SearchRouter {
        return Router.shared
    }
}


extension Router: SearchRouter {
    
    func closeSearch() {
        app()?
            .window?
            .rootViewController?
            .presentedViewController?
            .presentedViewController?
            .dismiss(animated: true)
    }
}
