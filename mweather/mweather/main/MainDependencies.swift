//
//  MainDependencies.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

protocol MainDependencies {
    func mainPresenter() -> MainPresenter
    func mainView() -> MainView
}

extension Dependencies: MainDependencies {
    
}
