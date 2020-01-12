//
//  Shimmer.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation
import UIKit

final class ShimmerConstants {
    static let keyPathAnimation = "locations"
    static let animationShimmer = "shimmer"
    static let alphaColor: CGFloat = 0.5
    static let shimmerDuration: Double = 0.9
    static let startPoint = CGPoint(x: 0, y: 0.5)
    static let endPoint = CGPoint(x: 1, y: 0.5)
}

extension UIView {
    private static var _shimmerBaseColor = UIColor.lightGray.withAlphaComponent(ShimmerConstants.alphaColor)
    
    var shimmerBaseColor: UIColor {
        get {
            return UIView._shimmerBaseColor
        }
        set(newValue) {
            UIView._shimmerBaseColor = newValue
        }
    }
    
    private static var disabledShimmer: Bool = ProcessInfo.processInfo.arguments.contains("UITest")
    
    // MARK: - Shimmer
    
    func startShimmering() {
        if UIView.disabledShimmer {
            return
        }
        
        let light = UIColor.white.cgColor
        let dark = shimmerBaseColor.cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [light, dark, dark, light]
        gradient.frame = CGRect(x: -bounds.width, y: 0, width: 3 * bounds.width, height: bounds.height)
        gradient.startPoint = ShimmerConstants.startPoint
        gradient.endPoint = ShimmerConstants.endPoint
        gradient.locations = [0.3, 0.4, 0.5, 0.6]
        layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: ShimmerConstants.keyPathAnimation)
        animation.fromValue = [0.0, 0.1, 0.2, 0.3]
        animation.toValue = [0.7, 0.8, 0.9, 1.0]
        animation.duration = ShimmerConstants.shimmerDuration
        animation.repeatCount = .infinity
        gradient.add(animation, forKey: ShimmerConstants.animationShimmer)
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
}
