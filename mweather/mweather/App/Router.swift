//
//  Router.swift
//  mweather
//
//  Created by ivan volnov on 7/4/19.
//  Copyright © 2019 ivolnov. All rights reserved.
//

import UIKit

class Router {
    static let shared = Router()
    private init() {}
}

extension Router {
    
    func app() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func alert(error: Error) {
        
        let alert = UIAlertController(
            title: ":(",
            message: "Something went wrong...",
            preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        
        DispatchQueue.main.async {
            self.app()?.window?.rootViewController?.present(alert, animated: true)
        }
    }
}
