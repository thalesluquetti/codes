//
//  CoinConversionSimulationViewController.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 11/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

final class CoinConversionSimulationViewController: UIViewController, Identifiable {
    
    // MARK: - Private Properties
    
    private var viewModel: CoinConversionSimulationViewModel?
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel? {
        didSet {
            titleLabel?.text = viewModel?.setupLabel()
        }
    }
    
    // MARK: - Initializers
    
    static func instantiate(viewModel: CoinConversionSimulationViewModel) -> CoinConversionSimulationViewController {
        let viewController: CoinConversionSimulationViewController = UIStoryboard.viewController(from: .coin)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
