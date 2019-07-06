//
//  CitiesAddCellRouter.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol CitiesAddCellRouter {
    func showSearch()
}

extension Dependencies {
    func citiesAddCellRouter() -> CitiesAddCellRouter {
        return Router.shared
    }
}

extension Router: CitiesAddCellRouter {
    func showSearch() {
        let vc = SearchViewController(dependencies: Dependencies.shared)
        app()?
            .window?
            .rootViewController?
            .presentedViewController?
            .present(vc, animated: true)
    }
}
