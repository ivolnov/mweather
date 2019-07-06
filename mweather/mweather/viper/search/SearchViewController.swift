//
//  SearchViewController.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    init(dependencies: SearchDependencies) {
        self.presenter = dependencies.searchPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let presenter: SearchPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
    }
}
