//
//  ForecastView.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

protocol ForecastView {
    var presenter: ForecastPresenter? { get set }
    var collectionView: UICollectionView { get }
    func show(activity: Bool)
    func choose(at: Int)
    func add(to: UIView)
    func reload()
    
}

extension Dependencies {
    func forecastView() -> ForecastView {
        return View()
    }
}

fileprivate class View: ForecastView {
    
    let buttonHoriaontalOffset: CGFloat = 6
    let buttonDimension: CGFloat = 44
    let footerHeight: CGFloat = 56
    
    weak var presenter: ForecastPresenter?
    
    let activityIndicator: UIActivityIndicatorView
    let collectionView: UICollectionView
    let buttonCities: UIButton
    let footer: UIView
    
    init() {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        buttonCities = UIButton.just(icon: #imageLiteral(resourceName: "ic_zoom_in"), in: .cadet)
        activityIndicator = UIActivityIndicatorView()
        footer = UIView()
    }
    
    func add(to root: UIView) {
        
        let delimeter = UIView()
        
        root.addSubview(activityIndicator)
        root.addSubview(collectionView)
        root.addSubview(delimeter)
        root.addSubview(footer)
        
        footer.addSubview(buttonCities)
        
        root.backgroundColor = .white

        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.contentOffset = .zero
        collectionView.bounces = false
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(root.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        delimeter.backgroundColor = .platinum
        delimeter.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.bottom.equalTo(footer.snp.top)
            make.height.equalTo(1)
        }
        
        footer.backgroundColor = .clear
        footer.snp.makeConstraints { make in
            make.bottom.equalTo(root.safeAreaLayoutGuide)
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(footerHeight)
        }
        
        buttonCities.addTarget(self, action: #selector(onButtonCitiesTap), for: .touchUpInside)
        buttonCities.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(buttonHoriaontalOffset)
            make.width.height.equalTo(buttonDimension)
            make.centerY.equalToSuperview()
        }
        
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .cadet
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func show(activity on: Bool) {
        activityIndicator.superview?.bringSubviewToFront(activityIndicator)
        activityIndicator.isHidden = !on
        on
            ? activityIndicator.startAnimating()
            : activityIndicator.stopAnimating()
        
    }
    
    func choose(at row: Int) {
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0),
                                    at: .centeredHorizontally,
                                    animated: false)
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
    @objc private func onButtonCitiesTap(_ button: UIButton) {
        presenter?.openCities()
    }
}
