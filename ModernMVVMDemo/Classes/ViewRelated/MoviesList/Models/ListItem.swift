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
extension ListItem {
    
    static let preview: [ListItem] = {
        return [
            .init(title: "Hello 1"),
            .init(title: "Hello 2"),
            .init(title: "Hello 3"),
        ]
    }()
}
#endif
