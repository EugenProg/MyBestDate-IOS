//
//  MatchMediator.swift
//  BestDate
//
//  Created by Евгений on 10.08.2022.
//

import Foundation

class MatchMediator: ObservableObject {
    static var shared: MatchMediator = MatchMediator()

    @Published var users: [MatchItem] = []
    @Published var currentUser: ShortUserInfo? = nil
    @Published var currentIndex: Int = 0

    func setMatchUsers(list: [ShortUserInfo]) {
        users.removeAll()
        for index in list.indices {
            users.append(
                MatchItem(id: index, user: list[index])
            )
        }
        currentUser = users[0].user
    }

    func getNextMatchPage() {
        MatchesApiService.shared.getMatchesList() { success, users in
            if success {
                DispatchQueue.main.async {
                    self.setMatchUsers(list: users)
                }
            }
        }
    }

    func matchAction(id: Int?) {
        MatchesApiService.shared.matchAction(userId: id ?? 0) { success in
            
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
}
