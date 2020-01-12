//
//  Identifiable.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

// MARK: - Identifiable protocol

/// Used to UIViewController that are stored in Storyboard
@objc protocol Identifiable: AnyObject {}

// MARK: - NibLoadableView protocol

/// Used to UIViewController that are stored in Storyboard
protocol NibLoadableView: AnyObject {}

// MARK: - Identifiable Extension on UIViewController

extension Identifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - NibLoadableView Extension on UIView

extension NibLoadableView where Self: UIView {
    /// Retrieves nibName by class name
    static var nibName: String {
        return String(describing: self)
    }
}
