//
//  Resource.swift
//  ExampleAppCoin
//
//  Created by Thales Luquetti Teixeira on 12/01/20.
//  Copyright © 2020 Thales Luquetti Teixeira. All rights reserved.
//

import Foundation

typealias AbortErrorHandling = () -> Void
typealias ResourceCompletion<T> = (Resource<T>) -> Void
typealias SuccessHandle<V> = (V) -> Void
typealias FailureHandle = (AppError, AbortErrorHandling) -> Void
typealias FinallyHandle = () -> Void

final class Resource<V> {
    
    // MARK: - Properties
    
    private let value: V?
    private let error: AppError?
    private var successHandle: SuccessHandle<V>?
    private var failureHandles = [FailureHandle]()
    private var finallyHandle: FinallyHandle?
    
    // MARK: - Initializer
    
    init(value: V) {
        self.value = value
        error = nil
    }
    
    init(error: AppError) {
        self.error = error
        value = nil
    }
    
    // MARK: - Public Methods
    
    func success(_ handle: @escaping SuccessHandle<V>) {
        successHandle = handle
    }
    
    func failure(_ handle: @escaping FailureHandle) {
        failureHandles.append(handle)
    }
    
    func finally(_ handle: @escaping FinallyHandle) {
        finallyHandle = handle
    }
    
    func execute(_ completion: ResourceCompletion<V>) {
        completion(self)
        
        if let success = value, let handle = successHandle {
            handle(success)
        } else if let failure = error {
            var stopHandlingErrors = false
            
            _ = failureHandles.first { handle in
                handle(failure) {
                    stopHandlingErrors = true
                }
                return stopHandlingErrors
            }
        }
        
        guard let finally = finallyHandle else { return }
        finally()
    }
}
