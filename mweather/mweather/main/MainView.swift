//
//  MainView.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

protocol MainView {
    func add(to: UIView)
}

extension Dependencies {
    func mainView() -> MainView {
        return View()
    }
}


fileprivate class View: MainView {
    
    func add(to root: UIView) {
        root.backgroundColor = .red
    }
}
