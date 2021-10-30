//
//  DTOs.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation

struct MovieItemDTO: Decodable {
    let id: Int
    let title: String
}

struct MovieDetailDTO: Decodable {
    let id: Int
    let title: String
}
