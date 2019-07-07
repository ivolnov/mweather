//
//  ForecastCellView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit

protocol ForecastCellView {
    var presenter: ForecastCellPresenter? { get set }
    func set(days: [ForecastCellViewModel])
    func hideRefreshControl()
    func add(to: UIView)
}

protocol ForecastCellViewModel {
    var icon: ForecastCellViewModelIcon { get }
    var temperature: String { get }
    var weather: String { get }
    var city: String { get }
    var day: String { get }
}

extension Dependencies {
    func forecastCellView() -> ForecastCellView {
        return View()
    }
}

fileprivate class View: ForecastCellView {
 
    let labelHorizontalOffset: CGFloat = 16
    let labelVerticlaOffset: CGFloat = 32
    let fontSizeMedium: CGFloat = 24
    let iconDimension: CGFloat = 32
    let fonSizeBig: CGFloat = 64
    let fontSize: CGFloat = 16
    
    private let refreshControl: UIRefreshControl
    
    private let labelWeather: UILabel
    private let labelToday: UILabel
    private let labelCity: UILabel

    private let labelTodayValue: UILabel
    private let labelTemperature: UILabel
    private let icon: UIImageView
    
    private let labelFirstTemperature: UILabel
    private let iconFirst: UIImageView
    private let labelFirstDay: UILabel
    
    private let labelSecondTemperature: UILabel
    private let iconSecond: UIImageView
    private let labelSecondDay: UILabel
    
    private let labelThirdTemperature: UILabel
    private let iconThird: UIImageView
    private let labelThirdDay: UILabel
    
    private let labelFourthTemperature: UILabel
    private let iconFourth: UIImageView
    private let labelFourthDay: UILabel
    
    weak var presenter: ForecastCellPresenter?
    
    init() {
        
        refreshControl = UIRefreshControl()
        
        labelCity = UILabel.size(fontSizeMedium, .cadet, .regular)
        labelWeather = UILabel.size(fontSize, .cadet, .regular)
        labelToday = UILabel.size(fontSize, .cadet, .regular)
       
        labelTemperature = UILabel.size(fonSizeBig, .black, .regular)
        labelTodayValue = UILabel.size(fontSize, .black, .regular)
       
        icon = UIImageView()
        
        labelFirstTemperature = UILabel.size(fontSize, .black, .regular)
        labelFirstDay = UILabel.size(fontSize, .cadet, .regular)
        iconFirst = UIImageView()
        
        labelSecondTemperature = UILabel.size(fontSize, .black, .regular)
        labelSecondDay = UILabel.size(fontSize, .cadet, .regular)
        iconSecond = UIImageView()
        
        labelThirdTemperature = UILabel.size(fontSize, .black, .regular)
        labelThirdDay = UILabel.size(fontSize, .cadet, .regular)
        iconThird = UIImageView()
        
        labelFourthTemperature = UILabel.size(fontSize, .black, .regular)
        labelFourthDay = UILabel.size(fontSize, .cadet, .regular)
        iconFourth = UIImageView()
    }
    
    func hideRefreshControl() {
        refreshControl.endRefreshing()
    }
    
    func set(days: [ForecastCellViewModel]) {
        if let today = days.get(at: 0) {
            labelTemperature.text = today.temperature
            labelToday.text = "Today"
            labelTodayValue.text = today.day
            labelWeather.text = today.weather
            icon.image = today.icon.image()
            labelCity.text = today.city
        }
        
        if let first = days.get(at: 1) {
            labelFirstTemperature.text = first.temperature
            iconFirst.image = first.icon.image()
            labelFirstDay.text = first.day
        }
        
        if let second = days.get(at: 2) {
            labelSecondTemperature.text = second.temperature
            iconSecond.image = second.icon.image()
            labelSecondDay.text = second.day
        }
        
        if let third = days.get(at: 3) {
            labelThirdTemperature.text = third.temperature
            iconThird.image = third.icon.image()
            labelThirdDay.text = third.day
        }
        
        if let forth = days.get(at: 4) {
            labelFourthTemperature.text = forth.temperature
            iconFourth.image = forth.icon.image()
            labelFourthDay.text = forth.day
        }
    }
    
    func add(to root: UIView) {
        
        let scrollView = UIScrollView()
        let containerToday = UIView()
        let containerRest = UIView()
        let delimeter = UIView()
        
        root.addSubview(scrollView)
        scrollView.addSubview(containerToday)
        scrollView.addSubview(containerRest)
        scrollView.addSubview(delimeter)

        containerToday.addSubview(labelWeather)
        containerToday.addSubview(labelToday)
        containerToday.addSubview(labelCity)

        containerToday.addSubview(labelTodayValue)
        containerToday.addSubview(labelTemperature)
        containerToday.addSubview(icon)

        containerRest.addSubview(labelFirstTemperature)
        containerRest.addSubview(labelFirstDay)
        containerRest.addSubview(iconFirst)

        containerRest.addSubview(labelSecondTemperature)
        containerRest.addSubview(labelSecondDay)
        containerRest.addSubview(iconSecond)

        containerRest.addSubview(labelThirdTemperature)
        containerRest.addSubview(labelThirdDay)
        containerRest.addSubview(iconThird)

        containerRest.addSubview(labelFourthTemperature)
        containerRest.addSubview(labelFourthDay)
        containerRest.addSubview(iconFourth)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.refreshControl = refreshControl
        scrollView.backgroundColor = .white
        scrollView.refreshControl?.addTarget(
            self,
            action: #selector(onRefresh),
            for: .valueChanged)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerToday.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(root)
        }

        labelCity.textAlignment = .center
        labelCity.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.top.equalToSuperview().offset(2 * labelVerticlaOffset)
        }

        labelWeather.textAlignment = .center
        labelWeather.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.top.equalTo(labelCity).offset(labelVerticlaOffset)
        }

        labelTemperature.textAlignment = .center
        labelTemperature.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.top.equalTo(labelWeather).offset(labelVerticlaOffset)
        }
        
        labelTodayValue.textAlignment = .left
        labelTodayValue.snp.makeConstraints { make in
            make.top.equalTo(labelTemperature.snp.bottom).offset(2 * labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.bottom.equalToSuperview().inset(labelVerticlaOffset)
            
        }

        labelToday.textAlignment = .left
        labelToday.snp.makeConstraints { make in
            make.leading.equalTo(labelTodayValue.snp.trailing).offset(labelHorizontalOffset / 2)
            make.top.equalTo(labelTemperature.snp.bottom).offset(2 * labelVerticlaOffset)
            make.bottom.equalToSuperview().inset(labelVerticlaOffset)
        }

        delimeter.backgroundColor = .platinum
        delimeter.snp.makeConstraints { make in
            make.top.equalTo(containerToday.snp.bottom)
            make.trailing.leading.equalTo(root)
            make.height.equalTo(1)
        }

        containerRest.snp.makeConstraints { make in
            make.leading.trailing.equalTo(root)
            make.top.equalTo(delimeter.snp.bottom)
            make.bottom.equalToSuperview()
        }

        labelFirstDay.textAlignment = .left
        labelFirstDay.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.top.equalToSuperview().offset(labelVerticlaOffset)
        }

        iconFirst.snp.makeConstraints { make in
            make.height.width.equalTo(iconDimension)
            make.centerY.equalTo(labelFirstDay)
        }

        labelFirstTemperature.setContentCompressionResistancePriority(.required, for: .horizontal)
        labelFirstTemperature.textAlignment = .right
        labelFirstTemperature.snp.makeConstraints { make in
            make.leading.equalTo(iconFirst.snp.trailing).offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.centerY.equalTo(labelFirstDay)
        }

        labelSecondDay.textAlignment = .left
        labelSecondDay.snp.makeConstraints { make in
            make.top.equalTo(labelFirstDay.snp.bottom).offset(labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
        }

        iconSecond.snp.makeConstraints { make in
            make.height.width.equalTo(iconDimension)
            make.centerY.equalTo(labelSecondDay)
        }

        labelSecondTemperature.setContentCompressionResistancePriority(.required, for: .horizontal)
        labelSecondTemperature.textAlignment = .right
        labelSecondTemperature.snp.makeConstraints { make in
            make.leading.equalTo(iconSecond.snp.trailing).offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.centerY.equalTo(labelSecondDay)
        }
        
        labelThirdDay.textAlignment = .left
        labelThirdDay.snp.makeConstraints { make in
            make.top.equalTo(labelSecondDay.snp.bottom).offset(labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
        }
        
        iconThird.snp.makeConstraints { make in
            
            make.height.width.equalTo(iconDimension)
            make.centerY.equalTo(labelThirdDay)
        }
        
        labelThirdTemperature.setContentCompressionResistancePriority(.required, for: .horizontal)
        labelThirdTemperature.textAlignment = .right
        labelThirdTemperature.snp.makeConstraints { make in
            make.leading.equalTo(iconThird.snp.trailing).offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.centerY.equalTo(labelThirdDay)
        }
        
        labelFourthDay.textAlignment = .left
        labelFourthDay.snp.makeConstraints { make in
            make.top.equalTo(labelThirdDay.snp.bottom).offset(labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.bottom.equalToSuperview().inset(labelVerticlaOffset)
        }
        
        iconFourth.snp.makeConstraints { make in
            make.height.width.equalTo(iconDimension)
            make.centerY.equalTo(labelFourthDay)
        }
        
        labelFourthTemperature.setContentCompressionResistancePriority(.required, for: .horizontal)
        labelFourthTemperature.textAlignment = .right
        labelFourthTemperature.snp.makeConstraints { make in
            make.leading.equalTo(iconFourth.snp.trailing).offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.centerY.equalTo(labelFourthDay)
        }
    }
    
    @objc private func onRefresh() {
        if let city = labelCity.text {
            presenter?.refresh(for: city)
        }
    }
}

