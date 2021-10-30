//
//  NewsAPI.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation

enum MoviesAPI {
    
    /// Fetch all movies
    ///
    case allMovies
    
    /// Movie details with movie id
    ///
    case movieDetails(Int)
}

extension MoviesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://www.google.com")!
    }
    
    var path: String {
        switch self {
        case .allMovies:
            return ""
        case .movieDetails(let id):
            return "\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allMovies:
            return .get
        case .movieDetails:
            return .get
        }
    }
    
    var body: Data {
        return Data()
    }
    
    var headers: [String : String] {
        return [:]
    }
}
