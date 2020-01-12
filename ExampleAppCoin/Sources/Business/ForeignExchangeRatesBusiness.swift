//
//  ForeignExchangeRatesBusiness.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class ForeignExchangeRatesBusiness {
    
    private var foreignExchangeRatesHTTPRequest: HTTPRequestProtocol
    private lazy var defaultHTTPProvider = HTTPProvider(configurationProtocol: DefaultHTTPConfiguration())
    
    // MARK: - Initializer
    
    init(foreignExchangeRatesHTTPRequest: HTTPRequestProtocol = ForeignExchangeRatesHTTPRequest()) {
        self.foreignExchangeRatesHTTPRequest = foreignExchangeRatesHTTPRequest
    }
    
    // MARK: - Public Methods
    
    /// fetch simulation anticipation data
    ///
    /// - Parameter completion: ResourceCompletion<SimulationAnticipationResponse>
    /// - Returns: SimulationAnticipationResponse
    func fetchForeignExchangeRates(urlPath: String, completion: @escaping ResourceCompletion<ForeignExchangeRatesModel>) -> RequestProtocol {
        foreignExchangeRatesHTTPRequest.urlPath = urlPath
        return foreignExchangeRatesHTTPRequest.fetch(provider: defaultHTTPProvider, resourceCompletion: completion)
    }
}
