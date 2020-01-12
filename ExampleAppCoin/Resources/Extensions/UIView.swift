//
//  UIView.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Creates view from nib
    ///
    /// - Parameters:
    ///   - withOwner: view owner
    ///   - options: nib options
    /// - Returns: view instance
    static func fromNib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T? where T: UIView {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)
        return nib.instantiate(withOwner: withOwner, options: options).first as? T
    }
}
