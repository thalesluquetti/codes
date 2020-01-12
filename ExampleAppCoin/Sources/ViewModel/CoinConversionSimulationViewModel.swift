//
//  CoinConversionSimulationViewModel.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

final class CoinConversionSimulationViewModel {
    
    // MARK: Public properties
    
    let initialCountrySelected: String?
    
    // MARK: Initializers
    
    init(initialCountrySelected: String) {
        self.initialCountrySelected = initialCountrySelected
    }
    
    // MARK: Public methods
    
    func setupLabel() -> String {
        return initialCountrySelected ?? ""
    }
}
