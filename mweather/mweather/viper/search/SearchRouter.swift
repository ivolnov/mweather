//
//  SearchRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol SearchRouter {
    
}

extension Dependencies {
    func searchRouter() -> SearchRouter {
        return Router.shared
    }
}


extension Router: SearchRouter {
    
}
