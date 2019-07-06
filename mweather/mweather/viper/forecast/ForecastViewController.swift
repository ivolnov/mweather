//
//  ForecastViewController.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    init(dependencies: ForecastDependencies) {
        self.presenter = dependencies.forecastPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let presenter: ForecastPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
    }
}

