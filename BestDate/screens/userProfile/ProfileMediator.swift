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
    
    @Published var selectedImage: Int = 0

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
                completion()
            }
        }
    }

    func clearUserData() {
        self.user = UserInfo()
        self.profileImages.removeAll()
        GuestsMediator.shared.clearGuestData()
        SearchMediator.shared.clearData()
        MainMediator.shared.clearUserData()
        MyDuelsMediator.shared.clearData()
        TopListMediator.shared.clearTopList()
        QuestionnaireMediator.shared.clearData()
        MatchMediator.shared.clearData()
        MatchesListMediator.shared.clearData()
        LikeListMediator.shared.clearData()
        InvitationMediator.shared.clearData()
        UserDataHolder.setSearchLocation(filter: .all)
        PusherMediator.shared.closePusherConnection()
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

    func getMainPhotoIndex() -> Int {
        for index in profileImages.indices {
            if profileImages[index].main == true { return index }
        }
        return 0
    }
}
