//
//  UITextField+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/7/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

import UIKit

extension UITextField {
    
    static func size(_ size: CGFloat,
                     _ color: UIColor,
                     _ weight: UIFont.Weight,
                     cursor: UIColor? = nil) -> UITextField {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: size, weight: weight)
        field.tintColor = cursor
        field.textColor = color
        return field
    }
    
    func set(placeholder: String, of color: UIColor? = nil, left inset: CGFloat? = nil) {
        
        self.placeholder = placeholder
        
        if let color = color {
            attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor : color])
        }
        
        if let inset = inset {
            let rect = CGRect(x: 0, y: 0, width: inset, height: frame.height)
            leftView = UIView(frame: rect)
            leftViewMode = .always
        }
    }
}
