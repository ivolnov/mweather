//
//  CitiesCellView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

protocol CitiesCellView {
    func set(model: CitiesCellViewModel)
    func attach(to: UIView)
}

protocol CitiesCellViewModel {
    var temperature: String { get }
    var city: String { get }
}

extension Dependencies {
    func citiesCellView() -> CitiesCellView {
        return View()
    }
}

fileprivate class View: CitiesCellView {
    
    let offset: CGFloat = 16
    
    private let labelTemperature = UILabel.size(14, .cadet, .regular)
    private let labelCity = UILabel.size(16, .black, .regular)
    
    private let container = UIView()
    
    func set(model: CitiesCellViewModel) {
        labelTemperature.text = model.temperature
        labelCity.text = model.city
    }
    
    func attach(to root: UIView) {
        
        let delimiter = UIView()
        
        container.addSubview(labelCity)
        container.addSubview(labelTemperature)
        container.addSubview(delimiter)
        root.addSubview(container)
        
        root.backgroundColor = .clear
        
        container.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
        
        labelCity.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(offset)
        }
        
        labelTemperature.textAlignment = .right
        labelTemperature.snp.makeConstraints { make in
            make.leading.equalTo(labelCity.snp.trailing).offset(offset)
            make.centerY.equalTo(labelCity.snp.centerY)
            make.trailing.equalToSuperview().inset(offset)
        }
        
        delimiter.backgroundColor = .platinum
        delimiter.snp.makeConstraints { make in
            make.top.equalTo(labelCity.snp.bottom).offset(offset)
            make.trailing.equalToSuperview().inset(offset)
            make.leading.equalToSuperview().offset(offset)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
