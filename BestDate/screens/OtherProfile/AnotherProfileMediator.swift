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

    func setUser(user: UserInfo) {
        self.user = user

        imageList.clearAndAddAll(list: user.photos)
    }
}
