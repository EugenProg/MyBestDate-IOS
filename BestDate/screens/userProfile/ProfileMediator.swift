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

    @Published var hasNewMatches: Bool = false
    @Published var hasNewInvitations: Bool = false
    @Published var hasNewLikes: Bool = false
    @Published var hasNewDuels: Bool = false

    @Published var selectedImage: Int = 0

    @Published var showShareSheet: Bool = false

    func setUser(user: UserInfo) {
        self.user = user
        self.mainPhoto = user.getMainPhoto()
        self.hasNewMatches = (user.new_matches ?? 0) > 0
        self.hasNewInvitations = (user.new_invitations ?? 0) > 0
        self.hasNewLikes = (user.new_likes ?? 0) > 0
        self.hasNewDuels = (user.new_duels ?? 0) > 0

        withAnimation {
            self.profileImages.clearAndAddAll(list: user.photos)
        }
    }

    func logout(completion: @escaping () -> Void) {
        CoreApiService.shared.logout { _ in
            DispatchQueue.main.async {
                self.clearUserData()
                completion()
            }
        }
    }

    func clearUserData() {
        self.user = UserInfo()
        self.profileImages.removeAll()
        self.mainPhoto = nil
        GuestsMediator.shared.clearGuestData()
        SearchMediator.shared.clearData()
        MainMediator.shared.clearUserData()
        MyDuelsMediator.shared.clearData()
        TopListMediator.shared.clearTopList()
        QuestionnaireMediator.shared.clearData()
        MatchMediator.shared.clearData()
        MatchesListMediator.shared.clearData()
        LikeListMediator.shared.clearData()
        ChatListMediator.shared.clearData()
        InvitationMediator.shared.clearData()
        UserDataHolder.shared.setSearchLocation(filter: .all)
        PusherMediator.shared.closePusherConnection()
    }

    func updateUserData(completion: @escaping () -> Void) {
        CoreApiService.shared.getUserData { success, user in
            if success {
                DispatchQueue.main.async {
                    MainMediator.shared.setUserInfo()
                    self.setUser(user: user)
                }
            }
            completion()
        }
    }

    func getMainPhotoIndex() -> Int {
        for index in profileImages.indices {
            if profileImages[index].main == true { return index }
        }
        return 0
    }
}
