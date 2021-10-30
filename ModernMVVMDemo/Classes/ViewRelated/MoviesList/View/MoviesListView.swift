//
//  MoviesListView.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import Foundation
import SwiftUI

struct MoviesListView: View {
    
    @ObservedObject
    private var viewModel = MoviesListViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Trending Movies")
        }
        .onAppear {
            viewModel.send(.onAppear)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.send(.onAppear)
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
//            Spinner(isAnimating: .constant(true))
            list(of: [])
        case .error(let error):
            Text(error.localizedDescription)
        case .loaded(let movies):
            list(of: movies)
        case .idle:
            EmptyView()
        case .empty:
            PlaceholderView(imageName: "rectangle.on.rectangle",
                            messageText: "No results found!", buttonTitle: "Reload") {
                
            }
        }
    }
    
    private func list(of movies: [ListItem]) -> some View {
        List {
            Section {
                ForEach(movies) { movie in
                    NavigationLink {
                        
                    } label: {
                        Text(movie.title)
                    }
                }
            } footer: {
                Spinner(isAnimating: .constant(viewModel.state.isLoading))
                    .xCentered()
                    
            }
        }
    }
}
