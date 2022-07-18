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

    func setUser(user: UserInfo) {
        self.user = user

        profileImages.removeAll()
        for index in 0...2 {
            setImageIfHas(number: index)
        }
    }

    private func setImageIfHas(number: Int) {
        if (user.photos?.count ?? 0) > number { profileImages.append(user.photos?[number] ?? ProfileImage())
        }
    }

    func logout(completion: @escaping () -> Void) {
        CoreApiService.shared.logout { _ in
            completion()
        }
    }
}
