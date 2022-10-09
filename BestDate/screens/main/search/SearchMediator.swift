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

    private let itemHeight: CGFloat = ((UIScreen.main.bounds.width - 9) / 2) + 54

    @Published var users: [ShortUserInfo?] = []
    @Published var meta: Meta = Meta()
    @Published var loadingMode: Bool = true

    @Published var scrollToStartPosition: Bool = false
    var savedPosition: CGFloat = 0

    var locationType: LocationFilterTypes = UserDataHolder.searchLocation
    var onlineType: OnlineFilterTypes = UserDataHolder.searchOnline

    func getUserList(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        loadingMode = true
        CoreApiService.shared.getUsersList(location: locationType, online: onlineType, page: page) { success, userList, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.users.addAll(list: userList, clear: withClear)
                    self.meta = meta
                }
                self.scrollToStartPosition = true
                self.loadingMode = false
            }
            completion()
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getUserList(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    func updateUserList(location: LocationFilterTypes?, online: OnlineFilterTypes?) {
        if location != nil && location != locationType {
            locationType = location ?? .all
            getUserList(withClear: true, page: 0) { }
        } else if online != nil && online != onlineType {
            onlineType = online ?? .all
            getUserList(withClear: true, page: 0) { }
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / itemHeight) * 2)
    }

    func clearData() {
        users.removeAll()
    }
}
