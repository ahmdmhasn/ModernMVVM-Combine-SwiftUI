//
//  MovieDetail.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import SwiftUI

/// MovieDetailView
/// 
struct MovieDetailView: View {
    
    @ObservedObject var viewModel: MovieDetailViewModel
    
    init(movieID: Int) {
        self.viewModel = MovieDetailViewModel(
            movieID: movieID
        )
    }
    
    var body: some View {
        NavigationView {
            Text("Showing details of movie with id: \(viewModel.movieID)")
        }
        .navigationTitle(viewModel.title)
    }
}

/// View Builders
///
private extension MovieDetailView {
   
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            Spinner()
        case .loaded(let details):
            detailsView(details: details)
        case .failure(let error):
            placeholderView(message: error.localizedDescription)
        }
    }
    
    func detailsView(details: MovieDetail) -> some View {
        EmptyView()
    }
    
    func placeholderView(message: String) -> some View {
        PlaceholderView(image: .exclamationMark,
                        titleText: "Error",
                        messageText: message)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieID: .zero)
    }
}
