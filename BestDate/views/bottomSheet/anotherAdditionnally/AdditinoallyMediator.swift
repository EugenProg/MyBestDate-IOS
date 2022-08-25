//
//  AdditinoallyMediator.swift
//  BestDate
//
//  Created by Евгений on 24.08.2022.
//

import Foundation

class AdditionallyMediator: ObservableObject {
    static var shared = AdditionallyMediator()

    @Published var isBlocked: Bool = false
    var userId: Int? = nil

    func setInfo(user: UserInfo) {
        self.isBlocked = user.blocked ?? false
        self.userId = user.id
    }

    func blockAction() {
        if isBlocked { unlockProfile() }
        else { blockProfile() }
    }

    func blockProfile() {
        CoreApiService.shared.blockUser(id: userId) { success in
            AnotherProfileMediator.shared.getUserById(id: self.userId ?? 0)
        }
    }

    func unlockProfile() {
        CoreApiService.shared.unlockUser(id: userId) { success in
            AnotherProfileMediator.shared.getUserById(id: self.userId ?? 0)
        }
    }
}
