//
//  ShimmerView.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

final class ShimmerView: UIView {
    
    // MARK: - Constants
    
    private let kCornerRadius: CGFloat = 4
    
    // MARK: - Outlets
    
    @IBOutlet private weak var viewsBlock: UIView?
    
    // MARK: - Public method
    
    /// Start shimmer
    func startShimmer() {
        guard let viewsBlock = viewsBlock else { return }
        
        for subView: UIView in viewsBlock.subviews {
            subView.layer.cornerRadius = kCornerRadius
        }
        viewsBlock.startShimmering()
    }
}
