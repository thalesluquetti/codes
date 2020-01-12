//
//  ErrorView.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol ErrorViewDelegate: AnyObject {
    func retryAction()
}

final class ErrorView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var retryButton: UIButton? {
        didSet {
            retryButton?.backgroundColor = .clear
            retryButton?.layer.cornerRadius = 5
            retryButton?.layer.borderWidth = 1
            retryButton?.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - Public properties
    
    weak var delegate: ErrorViewDelegate?
    
    // MARK: - Private methods
    
    @IBAction private func retryAction(_ sender: UIButton) {
        delegate?.retryAction()
        removeFromSuperview()
    }
}
