//
//  CitiesInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol CitiesInteractor {
    
}


extension Dependencies {
    func citiesInteractor() -> CitiesInteractor {
        return Interactor()
    }
}

fileprivate class Interactor: CitiesInteractor {
    
}
