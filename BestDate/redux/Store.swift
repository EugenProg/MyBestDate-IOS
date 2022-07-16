//
//  Store.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import Combine

final class Store: ObservableObject {
    var reducer: Reducer
    @Published var state: AppState
    
    init(state: AppState = .init(activeScreen: .START), reducer: Reducer) {
        self.state = state
        self.reducer = reducer
    }
    
    public func dispatch(action: Action) {
        state = reducer.reducer(state: state, action: action)
    }
}
