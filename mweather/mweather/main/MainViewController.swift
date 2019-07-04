//
//  MainViewController.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    init(dependencies: MainDependencies) {
        self.presenter = dependencies.mainPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let presenter: MainPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
    }
}

