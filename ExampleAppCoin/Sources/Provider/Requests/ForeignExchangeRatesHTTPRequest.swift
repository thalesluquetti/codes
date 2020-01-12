//
//  ForeignExchangeRatesHTTPRequest.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class ForeignExchangeRatesHTTPRequest: HTTPRequestProtocol {
    var httpMethod: HTTPRequestMethod = .get
    var urlPath: String = "https://api.exchangeratesapi.io/latest?base=BRL"
    var httpBody: Encodable?
    var queryParameters: [String]?
    var errorConveter: ErrorConverterProtocol?
}
