//
//  MainMediator.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import Foundation
import UIKit

class MainMediator: ObservableObject {
    static let shared = MainMediator()

    @Published var currentScreen: MainScreensType = .SEARCH
    @Published var hasNewMessages: Bool = false
    @Published var hasNewGuests: Bool = false
    @Published var user: UserInfo = UserInfo()
    @Published var mainPhoto: ProfileImage? = nil
    @Published var coinsCount: Int = 0

    var searchPage: (() -> Void)? = nil
    var matchPage: (() -> Void)? = nil
    var chatListPage: (() -> Void)? = nil
    var duelPage: (() -> Void)? = nil
    var guestsPage: (() -> Void)? = nil

    func setUserInfo() {
        self.user = UserDataHolder.shared.getUser()
        hasNewGuests = (user.new_guests ?? 0) > 0
        mainPhoto = user.getMainPhoto()
        self.coinsCount = user.getCoins()
        SearchMediator.shared.setSearchGender(searchGender: self.user.getSearchGender())
        SettingsMediator.shared.getUserSettings()
        LocationMediator.shared.updateItemsList()
        if !PusherMediator.shared.isConnected() {
            PusherMediator.shared.startPusher()
        }
    }

    func clearUserData() {
        self.user = UserInfo()
        self.mainPhoto = nil
        self.hasNewGuests = false
        self.hasNewMessages = false
        self.currentScreen = .SEARCH
    }

    func selectAction(type: MainScreensType) {
        switch type {
        case .SEARCH: if searchPage != nil { searchPage!() }
        case .MATCHES: if matchPage != nil { matchPage!() }
        case .CHAT_LIST: if chatListPage != nil { chatListPage!() }
        case .TOP_50: if duelPage != nil { duelPage!() }
        case .GUESTS: if guestsPage != nil { guestsPage!() }
        }
    }
}

enum MainScreensType {
    case SEARCH
    case MATCHES
    case CHAT_LIST
    case TOP_50
    case GUESTS

    static let width = UIScreen.main.bounds.width

    var offset: CGFloat {
        switch self {
        case .SEARCH: return MainScreensType.width * 2
        case .MATCHES: return MainScreensType.width
        case .CHAT_LIST: return 0
        case .TOP_50: return -MainScreensType.width
        case .GUESTS: return -(MainScreensType.width * 2)
        }
    }
}
