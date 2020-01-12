//
//  ForeignExchangeRatesModel.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

struct ForeignExchangeRatesModel: Codable {
    let base: String
    let date: String
    let rates: Rates
}

struct Rates: Codable {
    let usd: Decimal
    let brl: Decimal
    let pln: Decimal
    let php: Decimal
    let aud: Decimal
    let cad: Decimal
    let krw: Decimal
    
    private enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case brl = "BRL"
        case pln = "PLN"
        case php = "PHP"
        case aud = "AUD"
        case cad = "CAD"
        case krw = "KRW"
    }
}
