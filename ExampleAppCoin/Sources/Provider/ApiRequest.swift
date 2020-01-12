//
//  ApiRequest.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

struct ApiRequest: RequestProtocol {
    
    // MARK: - Properties
    
    var sessionTask: URLSessionTask
    
    // MARK: - Public Methods
    
    func cancel() {
        if sessionTask.state == .running || sessionTask.state == .suspended {
            sessionTask.cancel()
        }
    }
}
