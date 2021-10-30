//
//  MovieListItemView.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import SwiftUI

/// Movie List Item View
///
struct MovieListItemView: View {
    
    let item: MovieListItem
    
    var body: some View {
        VStack {
            CardView {
                Text(item.title)
            }
        }
    }
        
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItemView(
            item: MovieListItem(title: "Movie Title")
        )
    }
}
