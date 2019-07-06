//
//  SearchView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit


protocol SearchView {
    var presenter: SearchPresenter? { get set }
    func add(to: UIView)
    
}

extension Dependencies {
    func searchView() -> SearchView {
        return View()
    }
}


fileprivate class View: SearchView {
    
    weak var presenter: SearchPresenter?
    
    func add(to root: UIView) {
        
    }
}
