//
//  UIButton+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

extension UIButton {
    static func just(icon: UIImage, in color: UIColor? = nil) -> UIButton {
        let button = UIButton()
        button.setImage(icon.withRenderingMode(.alwaysTemplate), for: [])
        button.tintColor = color
        return button
    }
}
