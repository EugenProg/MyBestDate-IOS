//
//  AnotherProfileMediator.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import Foundation
import SwiftUI

class AnotherProfileMediator: ObservableObject {
    static var shared = AnotherProfileMediator()

    @Published var user: UserInfo = UserInfo()
    @Published var imageList: [ProfileImage] = []
    @Published var mainPhoto: ProfileImage = ProfileImage()
    @Published var mainLiked: Bool = false

    func setUser(user: ShortUserInfo) {
        self.mainPhoto = user.main_photo ?? ProfileImage()
        self.mainLiked = self.mainPhoto.liked ?? false
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
                    self.mainLiked = user.getMainPhoto()?.liked ?? false
                    self.imageList.clearAndAddAll(list: user.photos)
                }
            }
        }
    }

    func likePhoto(id: Int?) {
        ImagesApiService.shared.likeAImage(photoId: id ?? 0) { _ in
            DispatchQueue.main.async {
                withAnimation {
                    self.mainLiked = true
                }
            }
        }
    }

    func cleanUserData() {
        self.user = UserInfo()
        self.imageList.removeAll()
    }
}
