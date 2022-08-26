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

    @Published var selectedImage: Int = 0

    @Published var showShareSheet: Bool = false

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
        CreateInvitationMediator.shared.getInvitations()
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

    func likePhoto(id: Int?, completion: @escaping () -> Void) {
        ImagesApiService.shared.likeAImage(photoId: id ?? 0) { _ in
            self.getUserById(id: self.user.id ?? 0)
            completion()
        }
    }

    func getMainPhotoIndex() -> Int {
        for index in imageList.indices {
            if imageList[index].main == true { return index }
        }
        return 0
    }

    func cleanUserData() {
        self.user = UserInfo()
        self.imageList.removeAll()
        self.selectedImage = 0
    }
}
