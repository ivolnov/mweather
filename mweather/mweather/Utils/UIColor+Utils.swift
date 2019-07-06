//
//  UIColor+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let onyxTransparent = #colorLiteral(red: 0.01568627451, green: 0.01568627451, blue: 0.05882352941, alpha: 0.4)
    static let mediumSlateBlue = #colorLiteral(red: 0.3921568627, green: 0.4235294118, blue: 0.9725490196, alpha: 1)
    static let lightSlateGray = #colorLiteral(red: 0.4901960784, green: 0.4980392157, blue: 0.6549019608, alpha: 1)
    static let darkLavender = #colorLiteral(red: 0.5254901961, green: 0.2549019608, blue: 0.5764705882, alpha: 1)
    static let whiteSmoke = #colorLiteral(red: 0.9647058824, green: 0.9568627451, blue: 0.9803921569, alpha: 1)
    static let tuftsBlue = #colorLiteral(red: 0.2862745098, green: 0.4470588235, blue: 0.7490196078, alpha: 1)
    static let platinum = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
    static let ashGrey = #colorLiteral(red: 0.7254901961, green: 0.7215686275, blue: 0.7294117647, alpha: 1)
    static let manatee = #colorLiteral(red: 0.5921568627, green: 0.5921568627, blue: 0.5921568627, alpha: 1)
    static let cadet = #colorLiteral(red: 0.3490196078, green: 0.3725490196, blue: 0.4392156863, alpha: 1)
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   self.random(),
                       green: self.random(),
                       blue:  self.random(),
                       alpha: 1.0)
    }
    
    private static func random() -> CGFloat {
        return CGFloat( arc4random() ) / CGFloat(UInt32.max)
    }
}
