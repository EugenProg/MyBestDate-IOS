//
//  AnotherProfileMediator.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import Foundation

class AnotherProfileMediator: ObservableObject {
    static var shared = AnotherProfileMediator()

    @Published var user: UserInfo = UserInfo()
    @Published var imageList: [ProfileImage] = []
    @Published var mainPhoto: ProfileImage = ProfileImage()

    func setUser(user: ShortUserInfo) {
        self.mainPhoto = user.main_photo ?? ProfileImage()
        self.user = user.toUser()
        getUserById(id: user.id ?? 0)
    }

    func setUser(user: UserInfo) {
        self.mainPhoto = user.getMainPhoto() ?? ProfileImage()
        self.user = user
        getUserById(id: user.id ?? 0)
    }

    func getUserById(id: Int) {
        CoreApiService.shared.getUsersById(id: id) { success, user in
            DispatchQueue.main.async {
                if success {
                    self.user = user
                    self.imageList.clearAndAddAll(list: user.photos)
                }
            }
        }
    }

    func cleanUserData() {
        self.user = UserInfo()
        self.imageList.removeAll()
    }
}
