//
//  String+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/7/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

extension String {
    func capitalizeFirstLetter(only: Bool = false) -> String {
        let tail = only ? dropFirst() : lowercased().dropFirst()
        return prefix(1).uppercased() + tail
    }
}
