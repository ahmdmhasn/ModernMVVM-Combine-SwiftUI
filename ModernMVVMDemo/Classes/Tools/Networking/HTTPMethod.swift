//
//  HTTPMethod.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation

/// HTTP Request Method
///
enum HTTPMethod {
    
    /// Get
    ///
    case get
    
    /// Post
    ///
    case post
    
    /// Put
    ///
    case put
    
    /// Delete
    ///
    case delete
    
    /// Value accepted by url request
    /// 
    var representableValue: String {
        switch self {
        case .get:      return "GET"
        case .post:     return "POST"
        case .put:      return "PUT"
        case .delete:   return "DELETE"
        }
    }
}
