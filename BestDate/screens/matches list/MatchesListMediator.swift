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
    @Published var meta: Meta = Meta()
    var savedPosition: CGFloat = 0

    func getMatchesList(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        myPhoto = MainMediator.shared.mainPhoto
        loadingMode = true
        MatchesApiService.shared.getUserMatches(page: page) { success, matchesList, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.matches.addAll(list: matchesList, clear: withClear)
                    self.meta = meta
                    completion()
                    self.loadingMode = false
                }
            }
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getMatchesList(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / 96) * 2)
    }

    func clearData() {
        matches.removeAll()
    }
}
