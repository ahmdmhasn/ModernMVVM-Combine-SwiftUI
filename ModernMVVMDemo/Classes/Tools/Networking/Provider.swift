//
//  Provider.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation
import Combine

class Provider<Target: TargetType> {
    let session: URLSession
    let ioQueue: DispatchQueue
    let resultQueue: DispatchQueue
    
    /// Init
    ///
    init() {
        self.ioQueue = DispatchQueue(label: "networking-provider")
        self.resultQueue = DispatchQueue.main
        self.session = .shared
    }
    
    func requestPublisher(_ target: Target) -> AnyPublisher<Response, ProviderError> {
        return session.dataTaskPublisher(for: Endpoint(target: target).urlRequest())
            .subscribe(on: ioQueue)
            .map { Response(data: $0.data, response: $0.response) }
            .mapError { ProviderError(urlError: $0) }
            .receive(on: resultQueue)
            .eraseToAnyPublisher()
    }
}

/// Nested Types
///
extension Provider {
    
    /// Provider Response
    ///
    struct Response {
        
        /// Data
        ///
        let data: Data?
        
        /// URL Response
        ///
        let response: URLResponse?
    }
    
    /// Custom provider error
    ///
    enum ProviderError: LocalizedError {
        
        case custom(URLError)
        
        case unsupportedURL(String)
        
        init(urlError: URLError) {
            switch urlError {
            case URLError.unsupportedURL:
                self = .unsupportedURL(urlError.userInfo[NSURLErrorFailingURLStringErrorKey] as! String)
            default:
                self = .custom(urlError)
            }
        }
        
        /// A localized message describing what error occurred.
        var errorDescription: String? {
            switch self {
            case .unsupportedURL(let url):
                return "URL is not supported: \(url)"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
