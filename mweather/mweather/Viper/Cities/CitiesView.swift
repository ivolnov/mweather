//
//  CitiesView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit

protocol CitiesView {
    
    var presenter: CitiesPresenter? { get set }
    var tableView: UITableView { get }
    func hideRefreshControl()
    func add(to: UIView)
    func reload()
}

extension Dependencies {
    func citiesView() -> CitiesView {
        return View()
    }
}

fileprivate class View: CitiesView {
    weak var presenter: CitiesPresenter?
    
    let refreshControl = UIRefreshControl()
    let tableView = UITableView()
    
    func add(to root: UIView) {
        root.addSubview(tableView)
        
        tableView.estimatedRowHeight = root.bounds.height / 10
        
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(
            self,
            action: #selector(onRefresh),
            for: .valueChanged)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.contentInset = .zero
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func hideRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    @objc private func onRefresh() {
        presenter?.refresh()
    }
}
