//
//  HomeViewModel.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

enum StatusScreen {
    case loading
    case loaded
    case error
}

final class HomeViewModel {
    
    // MARK: - Constants
    
    private let brlImageName: String = "brl"
    private let usdImageName: String = "usd"
    
    // MARK: - Private properties
    
    private var manager: ForeignExchangeRatesManager?
    private var foreignExchangeRates: ForeignExchangeRatesModel?
    private var urlPath: String?
    
    // MARK: - Public properties
    
    var indexSelected: Dynamic<Int> = Dynamic(0)
    var statusScreen: Dynamic<StatusScreen> = Dynamic(.loading)
    
    // MARK: Initializers
    
    init(manager: ForeignExchangeRatesManager = ForeignExchangeRatesManager()) {
        self.manager = manager
    }
    
    // MARK: - Public methods
    
    /// Setup base coin title label
    ///
    /// - Returns: String
    func setupBaseCoinTitleLabel() -> String {
        return indexSelected.value == 0 ? Localizable.titleBrlCoin.localize() : Localizable.titleUsdCoin.localize()
    }
    
    /// Setup base coin name image
    ///
    /// - Returns: String
    func setupBaseCoinImage() -> String {
        return indexSelected.value == 0 ? brlImageName : usdImageName
    }
    
    /// Set url path by indexSelected
    func setUrlPath() {
        if indexSelected.value == 0 {
            urlPath = "https://api.exchangeratesapi.io/latest?base=BRL"
            return
        }
        urlPath = "https://api.exchangeratesapi.io/latest?base=USD"
    }
    
    /// Fetch data rates
    func fetchData() {
        statusScreen.value = .loading
        guard let urlPath = urlPath else { return }
        _ = manager?.fetchForeignExchangeRates(urlPath: urlPath) { [weak self] resource in
            guard let weakSelf = self else { return }
            
            resource.success { response in
                weakSelf.foreignExchangeRates = response
                weakSelf.statusScreen.value = .loaded
            }
            
            resource.failure { _, _ in
                weakSelf.statusScreen.value = .error
            }
        }
    }
    
    /// Get ViewModel cell by index row table view
    ///
    /// - Parameter index: Int
    /// - Returns: RatesTableViewCellViewModel
    func getViewModelCell(index: Int) -> RatesTableViewCellViewModel? {
        guard let rates = foreignExchangeRates?.rates else { return nil }
        switch index {
        case 1:
            return RatesTableViewCellViewModel(initials: "aud", value: rates.aud)
        case 2:
            return RatesTableViewCellViewModel(initials: "brl", value: rates.brl)
        case 3:
            return RatesTableViewCellViewModel(initials: "cad", value: rates.cad)
        case 4:
            return RatesTableViewCellViewModel(initials: "krw", value: rates.krw)
        case 5:
            return RatesTableViewCellViewModel(initials: "php", value: rates.php)
        case 6:
            return RatesTableViewCellViewModel(initials: "pln", value: rates.pln)
        default:
            return RatesTableViewCellViewModel(initials: "usd", value: rates.usd)
        }
    }
}
