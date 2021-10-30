//
//  MoviesListViewModel.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 29/10/2021.
//

import Foundation
import Combine

final class MoviesListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    
    init() {
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: DispatchQueue.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }
    
    func send(_ event: Event) {
        input.send(event)
    }
}

// MARK: State Reduce
//
private extension MoviesListViewModel {
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onMoviesLoaded(let movies):
                return movies.isEmpty ? .empty : .loaded(movies)
            case .onFailedToLoadMovies(let error):
                return .error(error)
            default:
                return state
            }
        case .loaded(let oldList):
            switch event {
            case .onMoviesLoaded(let movies):
                return .loaded(oldList + movies)
            default:
                return state
            }
        case .error:
            return state
        case .empty:
            return state
        }
    }
}

// MARK: - Feedback Factory
//
private extension MoviesListViewModel {
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else {
                return Empty().eraseToAnyPublisher()
            }
            
            return Just(Event.onMoviesLoaded(ListItem.preview))
                .delay(for: 2, scheduler: DispatchQueue.main)
                .catch { Just(Event.onFailedToLoadMovies($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback {
            _ in input
        }
    }
}

// MARK: Nested Types
//
extension MoviesListViewModel {
    
    enum State {
        case idle
        case loading
        case loaded([ListItem])
        case error(Error)
        case empty
        
        var isLoading: Bool {
            if case .loading = self {
                return true
            }
            
            return false
        }
    }

    enum Event {
        case onAppear
        case onSelectMovie(Int)
        case onMoviesLoaded([ListItem])
        case onFailedToLoadMovies(Error)
    }
}
