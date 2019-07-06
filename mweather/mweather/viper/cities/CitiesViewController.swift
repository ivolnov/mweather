//
//  CitiesViewController.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    init(dependencies: CitiesDependencies) {
        self.presenter = dependencies.citiesPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let presenter: CitiesPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
    }
}
