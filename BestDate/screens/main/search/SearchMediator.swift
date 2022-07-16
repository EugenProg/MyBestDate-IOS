//
//  SearchMediator.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import Foundation
import SwiftUI

class SearchMediator: ObservableObject {
    static let shared = SearchMediator()

    @Published var users: [UserInfo] = []
    var locationType: LocationFilterTypes = UserDataHolder.searchLocation
    var onlineType: OnlineFilterTypes = UserDataHolder.searchOnline

    func getUserList() {
        CoreApiService.shared.getUsersList(location: locationType, online: onlineType) { success, userList in
            DispatchQueue.main.async {
                withAnimation {
                    self.users.removeAll()
                    
                    for user in userList {
                        self.users.append(user)
                    }
                }
            }

        }
    }

    func updateUserList(location: LocationFilterTypes?, online: OnlineFilterTypes?) {
        if location != nil && location != locationType {
            locationType = location ?? .all
            getUserList()
        } else if online != nil && online != onlineType {
            onlineType = online ?? .all
            getUserList()
        }
    }
}
