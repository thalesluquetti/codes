//
//  HomeViewModelTests.swift
//  ExampleAppCoinTests
//
//  Created by Thales Luquetti Teixeira on 10/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import XCTest
@testable import ExampleAppCoin

class HomeViewModelTests: XCTestCase {

    private var viewModel: HomeViewModel?
    
    override func setUp() {
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        viewModel = nil
    }
    
    func testSetupBaseCoinTitleLabelIndex0() {
        let result = viewModel?.setupBaseCoinTitleLabel()
        XCTAssertEqual(result, "BRL - Real brasileiro")
    }
    
    func testSetupBaseCoinTitleLabelIndex1() {
        viewModel?.indexSelected.value = 1
        let result = viewModel?.setupBaseCoinTitleLabel()
        XCTAssertEqual(result, "USD - Dólar dos EUA")
    }
    
    func testSetupBaseCoinImageIndex0() {
        let result = viewModel?.setupBaseCoinImage()
        XCTAssertEqual(result, "brl")
    }
    
    func testSetupBaseCoinImageIndex1() {
        viewModel?.indexSelected.value = 1
        let result = viewModel?.setupBaseCoinImage()
        XCTAssertEqual(result, "usd")
    }

}
