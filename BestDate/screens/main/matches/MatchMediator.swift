//
//  MatchMediator.swift
//  BestDate
//
//  Created by Евгений on 10.08.2022.
//

import Foundation
import SwiftUI

class MatchMediator: ObservableObject {
    static var shared: MatchMediator = MatchMediator()

    @Published var users: [MatchItem] = []
    @Published var currentUser: ShortUserInfo? = nil
    @Published var currentIndex: Int = 0
    @Published var loadingMode: Bool = true

    private let pageSize: Int = 35
    var fullList: [ShortUserInfo] = []

    func setMatchUsers(list: [ShortUserInfo]) {
        users.removeAll()
        for index in list.indices {
            users.append(
                MatchItem(id: index, user: list[index])
            )
        }
        if !users.isEmpty { currentUser = users[0].user }
    }

    func getMatchPage() {
        loadingMode = true
        MatchesApiService.shared.getMatchesList() { success, users in
            if success {
                DispatchQueue.main.async {
                    self.fullList = users
                    self.currentIndex = 0
                    self.loadingMode = false
                    self.getNextPage()
                }
            }
        }
    }

    func getNextPage() {
        let currentMatchesPage = fullList.count < pageSize ? Array(fullList.prefix(fullList.count)) : Array(fullList.prefix(pageSize))
        self.setMatchUsers(list: currentMatchesPage)
        self.currentIndex = 0
        if !fullList.isEmpty { fullList = fullList.count < pageSize ? [] : Array(fullList.suffix(fullList.count - pageSize)) }
    }

    func matchAction(id: Int?, completion: @escaping (Match) -> Void) {
        MatchesApiService.shared.matchAction(userId: id ?? 0) { success, match in
            completion(match)
        }
    }

    func clearData() {
        users.removeAll()
        currentUser = nil
        currentIndex = 0
    }
}

struct MatchItem {
    var id: Int
    var user: ShortUserInfo?
    var offset: CGSize = CGSize.zero
    var rotation: Angle = Angle.zero
}
