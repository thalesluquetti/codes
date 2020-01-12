//
//  Decimal.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

extension Decimal {
    
    // MARK: - Constants
    
    private static let localeBrl = Locale(identifier: "pt-BR")
    private static let localeUsd = Locale(identifier: "en_US")
    private static let localePln = Locale(identifier: "pl_PL")
    private static let localePhp = Locale(identifier: "fil_PH")
    private static let localeAud = Locale(identifier: "en_AU")
    private static let localeCad = Locale(identifier: "en_CA")
    private static let localeKrw = Locale(identifier: "ko_KR")
    private static let paddingChar = " "
    private static let maximumFractionDigits = 4
    
    ///
    /// - Parameter value: input value
    /// - Returns: formatted value
    func toCurrency(initial: String = "brl") -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = Decimal.maximumFractionDigits
        currencyFormatter.locale = setLocale(by: initial)
        
        if ProcessInfo().operatingSystemVersion.majorVersion < 12 {
            guard let currencyFormatted = currencyFormatter.string(from: self as NSDecimalNumber) else {
                return String()
            }
            
            currencyFormatter.formatWidth = paddingSize(currencyFormatted: currencyFormatted)
            currencyFormatter.paddingPosition = .afterPrefix
            currencyFormatter.paddingCharacter = Decimal.paddingChar
        }
        
        if let currencyFormattedFull = currencyFormatter.string(from: self as NSDecimalNumber) {
            return currencyFormattedFull.replacingOccurrences(of: "-", with: "- ")
        }
        return String()
    }
    
    // MARK: - Private methods
    
    private func paddingSize(currencyFormatted: String) -> Int {
        return currencyFormatted.count + 1
    }
    
    private func setLocale(by initial: String) -> Locale {
        switch initial {
        case "aud":
            return Decimal.localeAud
        case "cad":
            return Decimal.localeCad
        case "usd":
            return Decimal.localeUsd
        case "krw":
            return Decimal.localeKrw
        case "php":
            return Decimal.localePhp
        case "pln":
            return Decimal.localePln
        default:
            return Decimal.localeBrl
        }
    }
}
