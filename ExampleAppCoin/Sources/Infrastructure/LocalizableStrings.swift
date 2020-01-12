//
//  LocalizableStrings.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

enum Localizable: String {
    
    // MARK: Splash
    
    case titleSplash
    case titleBrlCoin
    case titleUsdCoin
    case titleAudCoin
    case titlePhpCoin
    case titlePlnCoin
    case titleKrwCoin
    case titleCadCoin
    case cellNotFound
    
    // MARK: - Public Methods
    
    func localize() -> String {
        return rawValue.localize()
    }
}
