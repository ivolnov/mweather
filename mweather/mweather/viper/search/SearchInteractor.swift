//
//  SearchInteractor.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation


protocol SearchInteractor {
    
}


extension Dependencies {
    func searchInteractor() -> SearchInteractor {
        return Interactor()
    }
}


fileprivate class Interactor: SearchInteractor {
    
}
