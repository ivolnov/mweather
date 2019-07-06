//
//  UILabel+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func size(_ size: CGFloat, _ color: UIColor, _ weight: UIFont.Weight) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: weight)
        label.textColor = color
        return label
    }
}
