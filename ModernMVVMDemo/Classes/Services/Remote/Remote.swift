//
//  Networking.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation
import Combine

/// Remote
///
class Remote {
    
    /// MoviesAPI Provider
    ///
    private let provider = Provider<MoviesAPI>()
    
    /// Decoder
    ///
    private let decoder = JSONDecoder()
    
    /// Perform MoviesAPI request
    /// 
    func request<Model: Decodable>(_ target: MoviesAPI, type: Model.Type) -> AnyPublisher<Model, Error> {
        provider.requestPublisher(target)
            .tryMap { response in
                guard let data = response.data else {
                    throw NSError(domain: "No data found", code: -1, userInfo: nil)
                }
                
                return data
            }
            .decode(type: type.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}

/// Movies API Requests
///
extension Remote {
    
    func popularMovies() -> AnyPublisher<[MovieItemDTO], Error> {
        request(.allMovies, type: [MovieItemDTO].self)
    }
    
    func movieDetail(id: Int) -> AnyPublisher<MovieDetailDTO, Error> {
        request(.movieDetails(id), type: MovieDetailDTO.self)
    }
}
