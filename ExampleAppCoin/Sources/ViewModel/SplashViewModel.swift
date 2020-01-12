//
//  SplashViewModel.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class SplashViewModel {
    
    // MARK: - Constants
    
    private let nameLottieFile: String = "splashCoin"
    
    // MARK: - Public Methods
    
    func animationSplash() -> String {
        return nameLottieFile
    }
    
    func setupTitleLabel() -> String {
        return Localizable.titleSplash.localize()
    }
    
}
