//
//  ProfileMediator.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import Foundation
import SwiftUI

class ProfileMediator: ObservableObject {
    static var shared = ProfileMediator()

    @Published var user: UserInfo = UserInfo()
    @Published var profileImages: [ProfileImage] = []
    @Published var mainPhoto: ProfileImage? = nil

    func setUser(user: UserInfo) {
        self.user = user
        self.mainPhoto = user.getMainPhoto()

        withAnimation {
            self.profileImages.clearAndAddAll(list: user.photos)
        }
    }

    func logout(completion: @escaping () -> Void) {
        CoreApiService.shared.logout { _ in
            DispatchQueue.main.async {
                self.clearUserData()
                GuestsMediator.shared.clearGuestData()
                SearchMediator.shared.clearData()
                MainMediator.shared.clearUserData()
                MyDuelsMediator.shared.clearData()
                TopListMediator.shared.clearTopList()
                QuestionnaireMediator.shared.clearData()
                MatchMediator.shared.clearData()
                completion()
            }
        }
    }

    func clearUserData() {
        self.user = UserInfo()
        self.profileImages.removeAll()
    }

    func updateUserData(completion: @escaping () -> Void) {
        CoreApiService.shared.getUserData { success, user in
            if success {
                DispatchQueue.main.async {
                    MainMediator.shared.setUserInfo(user: user)
                    self.setUser(user: user)
                }
            }
            completion()
        }
    }
}
