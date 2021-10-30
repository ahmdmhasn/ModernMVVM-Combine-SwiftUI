//
//  MovieListItem.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import Foundation

struct MovieListItem: Identifiable {
    let id = UUID().uuidString
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
