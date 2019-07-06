//
//  CitiesAddCellView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

protocol CitiesAddCellView {
    var presenter: CitiesAddCellPresenter? { get set }
    func add(to: UIView)
}

extension Dependencies {
    func citiesAddCellView() -> CitiesAddCellView {
        return View()
    }
}

fileprivate class View: CitiesAddCellView {
    
    
    let buttonOffset: CGFloat = 6
    let buttonDimension: CGFloat = 44
    
    weak var presenter: CitiesAddCellPresenter?
    
    var container = UIView()

    func add(to root: UIView) {
        
        let buttonAdd = UIButton.just(icon: #imageLiteral(resourceName: "ic_zoom_in"), in: .cadet)
        let delimiter = UIView()
        
        container.addSubview(buttonAdd)
        container.addSubview(delimiter)
        
        root.addSubview(container)
        
        root.backgroundColor = .clear
        
        container.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
        
        buttonAdd.addTarget(self, action: #selector(onButtonAddTap), for: .touchUpInside)
        buttonAdd.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().offset(buttonOffset)
            make.trailing.equalToSuperview().inset(buttonOffset)
            
            make.width.height.equalTo(buttonDimension)
        }
    }
    
    @objc private func onButtonAddTap(_ button: UIButton) {
        presenter?.add()
    }
}

