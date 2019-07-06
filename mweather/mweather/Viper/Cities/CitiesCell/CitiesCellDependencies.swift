//
//  CitiesCellDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol CitiesCellDependencies {
    func citiesCellView() -> CitiesCellView
}

extension Dependencies: CitiesCellDependencies {
    func citiesCellDependencies() -> CitiesCellDependencies {
        return self
    }
}
