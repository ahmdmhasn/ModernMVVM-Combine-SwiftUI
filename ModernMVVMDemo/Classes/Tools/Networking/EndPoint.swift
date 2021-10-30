//
//  EndPoint.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation

/// Creates ready to use url request
///
struct Endpoint {
    
    /// Target Type
    ///
    let target: TargetType
    
    /// Init
    ///
    init(target: TargetType) {
        self.target = target
    }
    
    /// Returns fully created url request using target type
    /// 
    func urlRequest() -> URLRequest {
        let url = target.baseURL.appendingPathComponent(target.path)

        var request = URLRequest(url: url, timeoutInterval: 60)
        request.httpMethod = target.method.representableValue
        request.allHTTPHeaderFields = [:]
        request.httpBody = target.body
        
        return request
    }
}
