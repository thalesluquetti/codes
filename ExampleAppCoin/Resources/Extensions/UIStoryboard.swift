//
//  UIStoryboard.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// Creates a view controller from storyboard
    ///
    /// - Parameters:
    ///   - storyboard: storyboard name
    /// - Returns: view controller instance
    static func viewController<T: UIViewController>(from storyboard: UIStoryboard.Name) -> T where T: Identifiable {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.self.storyboardIdentifier) as? T else {
            fatalError("Could not instantiate ViewController with identifier: \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
    
    // Enum storyboard names
    enum Name: String {
        case coin = "Coin"
    }
}
