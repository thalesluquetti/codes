//
//  DefaultHTTPConfiguration.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

class DefaultHTTPConfiguration: HTTPProviderConfigurationProtocol {
    let urlSession: URLSessionProtocol = URLSession(configuration: .ephemeral, delegate: DefaultSessionDelegate(), delegateQueue: nil)
}
