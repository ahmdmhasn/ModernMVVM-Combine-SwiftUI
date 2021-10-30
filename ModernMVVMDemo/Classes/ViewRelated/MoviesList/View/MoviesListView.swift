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
        }
    }
}

/// Content View Builder
///
private extension MoviesListView {
    
    @ViewBuilder var content: some View {
        switch viewModel.state {
        case .loading:
            Spinner(isAnimating: .constant(true))
        case .error(let error):
            placeholderView(message: error.localizedDescription)
        case .loaded(let movies):
            list(of: movies)
        case .idle:
            EmptyView()
        case .empty:
            placeholderView(message: "No results found!")
        }
    }
    
    func list(of movies: [MovieListItem]) -> some View {
        List {
            Section {
                ForEach(movies) { movie in
                    NavigationLink {
                        MovieDetailView(movieID: movie.id)
                    } label: {
                        MovieListItemView(item: movie)
                    }
                }
            } footer: {
                Spinner(isAnimating: .constant(viewModel.state.isLoading))
                    .xCentered()
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
    
    func placeholderView(title: String = "Error", message: String) -> some View {
        PlaceholderView(image: Image(systemName: "rectangle.on.rectangle"),
                        titleText: title,
                        messageText: message,
                        buttonTitle: "Reload") {
            viewModel.send(.onReload)
        }
    }
}
