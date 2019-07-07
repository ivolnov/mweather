//
//  SearchView.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import SnapKit


protocol SearchView {
    var presenter: SearchPresenter? { get set }
    func set(city: SearchViewCityModel)
    func show(activity: Bool)
    func show(keybord: Bool)
    func add(to: UIView)
}

extension Dependencies {
    func searchView() -> SearchView {
        return View()
    }
}

protocol SearchViewCityModel {
    var temperature: String { get }
    var weather: String { get }
    var name: String { get }
}

fileprivate class View: NSObject, SearchView {
    
    let labelHorizontalOffset: CGFloat = 16
    let labelVerticlaOffset: CGFloat = 32
    let fontSizeMedium: CGFloat = 24
    let iconDimension: CGFloat = 32
    let fonSizeBig: CGFloat = 64
    let fontSize: CGFloat = 16
    
    weak var presenter: SearchPresenter?
    
    private let activityIndicator: UIActivityIndicatorView
    private let textFieldCity: UITextField
    private let labelTemperature: UILabel
    private let labelWeather: UILabel
    private let buttonBack: UIButton
    private let labelHint: UILabel
    private let labelCity: UILabel
    private let container: UIView

    override init() {
        labelTemperature = UILabel.size(fonSizeBig, .black, .regular)
        labelCity = UILabel.size(fontSizeMedium, .cadet, .regular)
        labelWeather = UILabel.size(fontSize, .cadet, .regular)
        labelHint = UILabel.size(fontSize, .black, .regular)
        buttonBack = UIButton.just(icon: #imageLiteral(resourceName: "ic_back"), in: .cadet)
        activityIndicator = UIActivityIndicatorView()
        textFieldCity = UITextField.size(
            fontSizeMedium,
            .cadet,
            .regular,
            cursor: .manatee)
        container = UIView()
        super.init()
    }
    
    func set(city: SearchViewCityModel) {
        labelTemperature.text = city.temperature
        labelWeather.text = city.weather
        labelCity.text = city.name
    }
    
    func add(to root: UIView) {
        
        let delimeter = UIView()
        
        root.addSubview(activityIndicator)
        root.addSubview(textFieldCity)
        root.addSubview(buttonBack)
        root.addSubview(delimeter)
        root.addSubview(container)
        root.addSubview(labelHint)
        
        container.addSubview(labelTemperature)
        container.addSubview(labelWeather)
        container.addSubview(labelCity)
        
        root.backgroundColor = .white
        
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .cadet
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        labelHint.text = "Enter a city name"
        labelHint.textAlignment = .left
        labelHint.snp.makeConstraints { make in
            make.top.equalTo(root.safeAreaLayoutGuide).offset(labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
        }
        
        buttonBack.addTarget(self, action: #selector(onButtonBackTap), for: .touchUpInside)
        buttonBack.snp.makeConstraints { make in
            make.leading.equalTo(labelHint.snp.trailing).offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
            make.height.width.equalTo(iconDimension)
            make.centerY.equalTo(labelHint)
        }
        
        textFieldCity.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textFieldCity.clearButtonMode = .always
        textFieldCity.becomeFirstResponder()
        textFieldCity.snp.makeConstraints { make in
            make.top.equalTo(labelHint.snp.bottom).offset(labelVerticlaOffset)
            make.leading.equalToSuperview().offset(labelHorizontalOffset)
            make.trailing.equalToSuperview().inset(labelHorizontalOffset)
        }
        
        delimeter.backgroundColor = .platinum
        delimeter.snp.makeConstraints { make in
            make.top.equalTo(textFieldCity.snp.bottom).offset(labelVerticlaOffset)
            make.trailing.leading.equalTo(root)
            make.height.equalTo(1)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onContainerTap))
        container.addGestureRecognizer(tapGesture)
        container.snp.makeConstraints { make in
            make.top.equalTo(delimeter.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
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
    }
    
    func show(keybord: Bool) {
        _ = keybord
            ? textFieldCity.becomeFirstResponder()
            : textFieldCity.resignFirstResponder()
        
    }
    
    func show(activity: Bool) {
        switch activity {
        case true:
            activityIndicator.isHidden = false
            activityIndicator
                .superview?
                .bringSubviewToFront(activityIndicator)
            activityIndicator.startAnimating()
            
        default:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let city = textField.text {
            presenter?.search(city: city)
        }
    }
    
    @objc func onContainerTap(_ sender: UITapGestureRecognizer) {
        presenter?.add()
    }
    
    @objc func onButtonBackTap() {
        presenter?.cancel()
    }
}
