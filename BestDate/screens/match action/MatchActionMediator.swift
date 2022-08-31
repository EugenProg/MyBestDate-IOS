//
//  MatchActionMediator.swift
//  BestDate
//
//  Created by Евгений on 28.08.2022.
//

import Foundation

class MatchActionMediator: ObservableObject {
    static var shared = MatchActionMediator()

    @Published var selectedMatch: Match? = nil
    @Published var myPhoto: ProfileImage? = nil

    func setMatch(match: Match) {
        self.selectedMatch = match
        self.myPhoto = MainMediator.shared.mainPhoto
    }
}
