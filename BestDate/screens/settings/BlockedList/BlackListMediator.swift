//
//  BlackListMediator.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import Foundation

class BlackListMedialtor: ObservableObject {
    static var shared = BlackListMedialtor()

    @Published var list: [ShortUserInfo?] = []
    @Published var loadingMode: Bool = true

    func getBlockedList() {
        loadingMode = true
        CoreApiService.shared.getBlockedList { success, usersList in
            DispatchQueue.main.async {
                self.list.addAll(list: usersList, clear: true)
                self.loadingMode = false
            }
        }
    }

    func unlockProfile(userId: Int) {
        CoreApiService.shared.unlockUser(id: userId) { success in
            self.getBlockedList()
        }
    }
}
