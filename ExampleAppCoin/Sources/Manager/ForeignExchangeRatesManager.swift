//
//  ForeignExchangeRatesManager.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class ForeignExchangeRatesManager {
    
    // MARK: - Private properties
    
    private var business: ForeignExchangeRatesBusiness?
    
    // MARK: Initializers
    
    init(business: ForeignExchangeRatesBusiness = ForeignExchangeRatesBusiness()) {
        self.business = business
    }
    
    // MARK: - Public Methods
    
    /// fetch data
    ///
    /// - Parameters:
    ///   - urlPath: String
    ///   - completion: ForeignExchangeRatesModel
    func fetchForeignExchangeRates(urlPath: String, completion: @escaping ResourceCompletion<ForeignExchangeRatesModel>) {
        _ = business?.fetchForeignExchangeRates(urlPath: urlPath, completion: { result in
            completion(result)
        })
    }
    
}
