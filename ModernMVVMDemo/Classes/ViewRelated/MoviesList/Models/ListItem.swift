//
//  ListItem.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import Foundation

struct ListItem: Identifiable {
    let id = UUID().uuidString
    let title: String
}

#if DEBUG
import Combine

extension ListItem {
    
    static let preview: AnyPublisher<[ListItem], Never> = {
        return [
            ListItem(title: "Hello 1"),
            ListItem(title: "Hello 2"),
            ListItem(title: "Hello 3"),
        ]
            .publisher
            .collect()
            .delay(for: 2, scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }()
}
#endif
