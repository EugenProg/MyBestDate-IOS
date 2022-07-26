//
//  ProfileMediator.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import Foundation

class ProfileMediator: ObservableObject {
    static var shared = ProfileMediator()

    @Published var user: UserInfo = UserInfo()
    @Published var profileImages: [ProfileImage] = []
    @Published var mainPhoto: ProfileImage? = nil

    init() {
        PhotoSettingsSheetMediator.shared.updateAction = updateImageStatus()

        PhotoSettingsSheetMediator.shared.deleteAction = deleteImage()
    }

    func setUser(user: UserInfo) {
        self.user = user
        self.mainPhoto = user.getMainPhoto()

        profileImages.removeAll()
        for index in 0...2 {
            setImageIfHas(number: index)
        }
    }

    private func setImageIfHas(number: Int) {
        if (user.photos?.count ?? 0) > number {
            profileImages.append(user.photos?[number] ?? ProfileImage())
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
                completion()
            }
        }
    }

    func clearUserData() {
        self.user = UserInfo()
        self.profileImages.removeAll()
    }

    func deleteImage() -> (Int) -> Void {
        return { id in
            self.updateUserData()
        }
    }

    func updateImageStatus() -> (ProfileImage?) -> Void {
        return { image in
            self.updateUserData()
        }
    }

    func updateUserData() {
        CoreApiService.shared.getUserData { success, user in
            if success {
                DispatchQueue.main.async {
                    MainMediator.shared.setUserInfo(user: user)
                    self.setUser(user: user)
                }
            }
        }
    }
}
