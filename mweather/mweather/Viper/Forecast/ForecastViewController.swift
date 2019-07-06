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
        cellDependencies = dependencies.forecastCellDependencies()
        presenter = dependencies.forecastPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let cellDependencies: ForecastCellDependencies
    private let presenter: ForecastPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
        setUpCollectionView()
    }
}

extension ForecastViewController:
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cities().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        cell.dependencies = cellDependencies
        return cell
    }
    

}

extension ForecastViewController {
    private func setUpCollectionView() {
        presenter.view.collectionView.dataSource = self
        presenter.view.collectionView.delegate = self
        presenter.view.collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: "ForecastCell")
    }
}
