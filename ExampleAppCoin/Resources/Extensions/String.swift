//
//  String.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

extension String {
    
    /// Wrapper method to access Localized string
    ///
    /// - Returns: String from Localizable.strings file
    func localize() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
}
