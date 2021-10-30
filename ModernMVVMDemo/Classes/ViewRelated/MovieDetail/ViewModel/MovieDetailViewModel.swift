//
//  MovieDetailViewModel.swift
//  ModernMVVMDemo
//
//  Created by Ahmed M. Hassan on 30/10/2021.
//

import Foundation
import Combine

/// Movie Detail View Model
///
class MovieDetailViewModel: ObservableObject {
    @Published private(set) var state: State
    @Published private(set) var title = String()
    
    private let input = PassthroughSubject<Event, Never>()
    private var bag = Set<AnyCancellable>()
    
    
    init(movieID: Int) {
        self.state = .idle(movieID)
        
        Publishers.system(initial: state,
                          reduce: Self.reduce,
                          scheduler: DispatchQueue.main,
                          feedbacks: [
                            Self.userInput(input.eraseToAnyPublisher()),
                            Self.whenLoading(),
                          ])
            .assign(to: \.state, on: self)
            .store(in: &bag)
    }
    
    func send(event: Event) {
        input.send(event)
    }
}

/// System
///
extension MovieDetailViewModel {

    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let id):
            switch event {
            case .onAppear:
                return .loading(id)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onLoaded(let movie):
                return .loaded(movie)
            case .onFailedToLoad(let error):
                return .failure(error)
            default:
                return state
            }
        case .loaded:
            return state
        case .failure:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let id) = state else {
                return Empty()
                    .eraseToAnyPublisher()
            }
            
            return Empty()
                .eraseToAnyPublisher()
        }
    }
    
    static func userInput(_ input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}

/// Nested Types
///
extension MovieDetailViewModel {
    
    enum State {
        case idle(Int)
        case loading(Int)
        case loaded(MovieDetail)
        case failure(Error)
    }
    
    enum Event {
        case onAppear
        case onLoaded(MovieDetail)
        case onFailedToLoad(Error)
    }
}
