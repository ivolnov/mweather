//
//  Array+Utils.swift
//  mweather
//
//  Created by ivan volnov on 7/6/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import Foundation

extension Array {
    
    func get(at position: Int) -> Element? {
        return position < count
            ? self[position]
            : nil
    }
}
