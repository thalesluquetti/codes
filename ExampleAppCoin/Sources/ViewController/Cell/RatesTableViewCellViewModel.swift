//
//  RatesTableViewCellViewModel.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class RatesTableViewCellViewModel {
    
    // MARK: - Private properties
    
    let initialsName: String
    let valueCoin: Decimal
   
    init(initials: String, value: Decimal) {
        valueCoin = value
        initialsName = initials
    }
    
    // MARK: - Public methods
    
    func getTitleCoin() -> String {
        return setTitle(by: initialsName)
    }
    
    func getImageName() -> String {
        return initialsName
    }
    
    // MARK: - Private methods
    
    private func setTitle(by initial: String) -> String {
        switch initial {
        case "aud":
            return Localizable.titleAudCoin.localize()
        case "cad":
            return Localizable.titleCadCoin.localize()
        case "usd":
            return Localizable.titleUsdCoin.localize()
        case "krw":
            return Localizable.titleKrwCoin.localize()
        case "php":
            return Localizable.titlePhpCoin.localize()
        case "pln":
            return Localizable.titlePlnCoin.localize()
        default:
            return Localizable.titleBrlCoin.localize()
        }
    }
}
