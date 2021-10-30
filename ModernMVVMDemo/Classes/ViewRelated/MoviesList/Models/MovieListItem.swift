//
//  MovieListItem.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import Foundation

struct MovieListItem: Identifiable {
    let id = Int.random(in: 0...10000)
    let title: String
}

#if DEBUG
import Combine

extension MovieListItem {
    
    static let preview: AnyPublisher<[MovieListItem], Never> = {
        return [
            MovieListItem(title: "Hello 1"),
            MovieListItem(title: "Hello 2"),
            MovieListItem(title: "Hello 3"),
        ]
            .publisher
            .collect()
            .delay(for: 2, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }()
}
#endif
