//
//  HTTPProvider.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

typealias FetchCompletion<T, R> = (HTTPURLResponse, T) throws -> R
typealias NetworkCompletion = (() throws -> (HTTPURLResponse, Data)) -> Void

/// Enum with request methods
enum HTTPRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

/// Enum to conversion error
public enum AppError: Swift.Error {
    case http(Int, Data)
    case unexpected(Swift.Error)
    case custom(Swift.Error)
    case ignored(Swift.Error)
    case notConnected
    case timedOut
}

// MARK: - Protocols

/// Protocol request
protocol RequestProtocol {
    
    // MARK: - Public Methods
    
    func cancel()
}

/// Protocol error converter
protocol ErrorConverterProtocol {
    
    // MARK: - Public Methods
    
    func convert(error: Swift.Error) -> AppError
}

/// Protocol url session
protocol URLSessionProtocol {
    
    // MARK: - Public Methods
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

/// Protocol configuration provider
protocol HTTPProviderConfigurationProtocol {
    
    // MARK: - Properties
    
    var urlSession: URLSessionProtocol { get }
}

/// Protocol request properties and methods
protocol HTTPRequestProtocol {
    
    // MARK: - Properties
    
    var httpMethod: HTTPRequestMethod { get }
    var urlPath: String { get set }
    var httpBody: Encodable? { get set }
    var queryParameters: [String]? { get set }
    var errorConveter: ErrorConverterProtocol? { get set }

    // MARK: - Public Methods
    
    func fetch<T: Decodable>(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<T>) -> RequestProtocol
    func fetch(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<Void>) -> RequestProtocol
}

/// Protocol provider properties and methods
protocol HTTPProviderProtocol {
    // MARK: - Properties
    
    var configurationProtocol: HTTPProviderConfigurationProtocol { get }
    
    // MARK: - Public Methods
    
    func request(_ request: HTTPRequestProtocol, completion: @escaping NetworkCompletion) -> RequestProtocol
}

final class HTTPProvider: HTTPProviderProtocol {
    
    // MARK: - Properties
    
    let configurationProtocol: HTTPProviderConfigurationProtocol
    
    // MARK: - Initializers
    
    init(configurationProtocol: HTTPProviderConfigurationProtocol) {
        self.configurationProtocol = configurationProtocol
    }
    
    // MARK: - Public Methods
    
    func request(_ request: HTTPRequestProtocol, completion: @escaping NetworkCompletion) -> RequestProtocol {
        let urlRequest = createURLRequest(request)
        
        let sessionTask: URLSessionTask = configurationProtocol.urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            self?.handleRequest(data: data, response: response, error: error, request: request, completion: completion)
        }
        sessionTask.resume()
        return ApiRequest(sessionTask: sessionTask)
    }
    
    // MARK: - Private Methods
    
    private func handleRequest(data: Data?, response: URLResponse?, error: Error?, request: HTTPRequestProtocol, completion: @escaping NetworkCompletion) {
        do {
            if let error = error {
                throw error
            }
            
            guard let httpResponse = response as? HTTPURLResponse, let responseData = data else {
                throw AppError.unexpected(URLError(URLError.cannotParseResponse))
            }
            
            // check if there is an httpStatus code ~= 200...299 (Success)
            if 200 ... 299 ~= httpResponse.statusCode {
                DispatchQueue.main.async {
                    completion { (httpResponse, responseData as Data) }
                }
            } else {
                throw AppError.http(httpResponse.statusCode, responseData)
            }
        } catch {
            DispatchQueue.main.async {
                completion {
                    if let appError = request.errorConveter?.convert(error: error) {
                        throw appError
                    }
                    throw DefaultErrorConverter().convert(error: error)
                }
            }
        }
    }
    
    private func createURLRequest(_ request: HTTPRequestProtocol) -> URLRequest {
        let urlRequest = NSMutableURLRequest()
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        // convert url string in URL
        guard let completeURL = URL(string: request.urlPath) else {
            assertionFailure("Invalid URL")
            return urlRequest as URLRequest
        }
        guard var urlComponents = URLComponents(url: completeURL, resolvingAgainstBaseURL: false) else {
            assertionFailure("Invalid URL")
            return urlRequest as URLRequest
        }
        
        // adding parameters to body
        if let httpBody = request.httpBody, let data = httpBody.encodedData {
            urlRequest.httpBody = data
        }
        
        // adding parameters to query string
        if let parametersItems = request.queryParameters {
            urlComponents.query = parametersItems.joined(separator: "&")
        }
        
        urlRequest.url = urlComponents.url
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        
        return urlRequest as URLRequest
    }
}

// MARK: - Extensions

extension HTTPRequestProtocol {
    
    // MARK: - Public Methods
    
    public func fetch<T: Decodable, R>(provider: HTTPProviderProtocol,
                                       resourceCompletion: @escaping ResourceCompletion<R>,
                                       resourceTransformer: @escaping (FetchCompletion<T, R>)) -> RequestProtocol {
        func networkCompletion(_ response: () throws -> (HTTPURLResponse, Data)) {
            var resource: Resource<R>?
            do {
                let (httpResponse, data) = try response()
                
                let result: T = try JSONDecoder().decode(T.self, from: data)
                resource = Resource(value: try resourceTransformer(httpResponse, result))
            } catch {
                resource = handleError(error: error)
            }
            resource?.execute(resourceCompletion)
        }
        return provider.request(self, completion: networkCompletion)
    }
    
    public func fetch<T: Decodable>(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<T>) -> RequestProtocol {
        return fetch(provider: provider, resourceCompletion: resourceCompletion) { (_, result: T) in
            result
        }
    }
    
    public func fetch(provider: HTTPProviderProtocol, resourceCompletion: @escaping ResourceCompletion<Void>) -> RequestProtocol {
        return fetch(provider: provider) { (resource: Resource<EmptyResult>) in
            resource.success { _ in
                let resource = Resource(value: ())
                resource.execute(resourceCompletion)
            }
            resource.failure { error, _ in
                let resource = Resource<Void>(error: error)
                resource.execute(resourceCompletion)
            }
        }
    }
    
    // MARK: - Private methods
    
    private func handleError<T>(error: Swift.Error) -> Resource<T>? {
        switch error {
        case AppError.ignored:
            return nil
        case let appError as AppError:
            return Resource(error: appError)
        default:
            return Resource(error: AppError.unexpected(error))
        }
    }
}

struct EmptyResult: Codable {}
extension URLSession: URLSessionProtocol {}
