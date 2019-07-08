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
        self.citiesAddCellDependencies = dependencies.citiesAddCellDependencies()
        self.citiesCellDependencies = dependencies.citiesCellDependencies()
        self.presenter = dependencies.citiesPresenter()
        super.init(nibName: nil, bundle: nil)
    }
    
    private let citiesAddCellDependencies: CitiesAddCellDependencies
    private let citiesCellDependencies: CitiesCellDependencies
    private let presenter: CitiesPresenter
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view.add(to: view)
        setUp(presenter.view.tableView)
    }
    
    private func setUp(_ tableView: UITableView) {
        tableView.register(CitiesAddCell.self, forCellReuseIdentifier: "CitiesAddCell")
        tableView.register(CitiesCell.self, forCellReuseIdentifier: "CitiesCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cities = presenter.cities()
        
        switch indexPath.row {
            
        case cities.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesAddCell",
                                                     for: indexPath) as! CitiesAddCell
            cell.dependencies = citiesAddCellDependencies
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CitiesCell",
                                                     for: indexPath) as! CitiesCell
            
            if let presenterModel = cities.get(at: indexPath.row ) {
                cell.dependencies = citiesCellDependencies
                let cellModel = convert(presenterModel)
                cell.model = cellModel
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let last = tableView.numberOfRows(inSection: 0) - 1
        return indexPath.row != last
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cities = presenter.cities()
        return cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.select(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            presenter.delete(at: indexPath.row)
        default:
            ()
        }
    }
    
    private func convert(_ model: CitiesPresenterModel) -> CitiesCellViewModel {
        return Model(temperature: model.temperature, city: model.city)
    }
}

fileprivate struct Model: CitiesCellViewModel {
    let temperature: String
    let city: String
}
