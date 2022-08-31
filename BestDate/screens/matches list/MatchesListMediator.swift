//
//  MatchesListMediator.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import Foundation
import SwiftUI

class MatchesListMediator: ObservableObject {
    static var shared = MatchesListMediator()

    @Published var matches: [Match] = []
    @Published var myPhoto: ProfileImage? = nil
    @Published var loadingMode: Bool = true
    var savedPosition: CGFloat = 0

    func getMatchesList(completion: @escaping () -> Void) {
        myPhoto = MainMediator.shared.mainPhoto
        loadingMode = true
        MatchesApiService.shared.getUserMatches { success, matchesList in
            DispatchQueue.main.async {
                withAnimation {
                    self.matches.clearAndAddAll(list: matchesList)
                    completion()
                    self.loadingMode = false
                }
            }
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / 96) * 2)
    }

    func clearData() {
        matches.removeAll()
    }
}
