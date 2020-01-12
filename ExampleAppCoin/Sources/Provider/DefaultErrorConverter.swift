//
//  DefaultErrorConverter.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

class DefaultErrorConverter: ErrorConverterProtocol {
    
    // MARK: - Public Methods
    
    func convert(error: Error) -> AppError {
        switch URLError.Code(rawValue: error._code) {
        case .timedOut:
            return AppError.timedOut
        case .notConnectedToInternet:
            return AppError.notConnected
        case .cancelled:
            return AppError.ignored(error)
        default:
            return AppError.unexpected(error)
        }
    }
}
