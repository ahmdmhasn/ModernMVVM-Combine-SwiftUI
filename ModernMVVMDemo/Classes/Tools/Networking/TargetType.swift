//
//  TargetType.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation

protocol TargetType {
    
    /// Base url for the target
    ///
    var baseURL: URL { get }
    
    /// Path. Should be appended on base url
    ///
    var path: String { get }
    
    /// HTTP Method Type
    ///
    var method: HTTPMethod { get }
    
    /// Request Body
    ///
    var body: Data { get }
    
    /// Headers
    /// 
    var headers: [String: String] { get }
}
