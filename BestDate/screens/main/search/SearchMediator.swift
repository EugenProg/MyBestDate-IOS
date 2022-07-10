//
//  SearchMediator.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import Foundation

class SearchMediator: ObservableObject {
    static let shared = SearchMediator()

    @Published var users: [UserInfo] = []

    func getUserList() {
        CoreApiService.shared.getUsersList { success, userList in
            DispatchQueue.main.async {
                self.users.removeAll()
                
                for user in userList {
                    self.users.append(user)
                }
            }

        }
    }
}
