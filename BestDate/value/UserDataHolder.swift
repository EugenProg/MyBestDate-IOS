//
//  UserDataHolder.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class UserDataHolder : UserDefaultsUtil {
    static var shared: UserDataHolder = UserDataHolder()

    func setAuthData(response: AuthResponse?) {
        if response != nil {
            setSettings(type: .ACCESS_TOKEN, value: "Bearer \(response?.access_token ?? "")")
            setSettings(type: .REFRESH_TOKEN, value: response?.refresh_token ?? "")
        }
    }

    func getAccessToken() -> String {
        getSettings(type: .ACCESS_TOKEN) ?? ""
    }

    func getRefreshToken() -> String {
        getSettings(type: .REFRESH_TOKEN) ?? ""
    }

    func setNotificationToken(token: String?) {
        if token != nil {
            setSettings(type: .NOTIFICATION_TOKEN, value: token!)
        }
    }

    func getNotificationToken() -> String {
        getSettings(type: .NOTIFICATION_TOKEN) ?? ""
    }

    func setStartScreen(screen: ScreenList) {
        setSettings(type: .START_SCREEN, value: screen.rawValue)
    }

    func getStartScreen() -> ScreenList {
        ScreenList(rawValue: getSettings(type: .START_SCREEN) ?? ScreenList.START.rawValue) ?? ScreenList.START
    }

    func setSearchOnline(filter: OnlineFilterTypes) {
        if filter == .filter {
            setSettings(type: .SEARCH_ONLINE, value: OnlineFilterTypes.all.rawValue)
        } else {
            setSettings(type: .SEARCH_ONLINE, value: filter.rawValue)
        }
    }

    func getSearchOnlineFilter() -> OnlineFilterTypes {
        OnlineFilterTypes(rawValue: getSettings(type: .SEARCH_ONLINE) ?? OnlineFilterTypes.all.rawValue) ?? OnlineFilterTypes.all
    }

    func setSearchLocation(filter: LocationFilterTypes) {
        if filter == .filter {
            setSettings(type: .SEARCH_LOCATION, value: LocationFilterTypes.all.rawValue)
        } else {
            setSettings(type: .SEARCH_LOCATION, value: filter.rawValue)
        }
    }

    func getSearchLocationFilter() -> LocationFilterTypes {
        LocationFilterTypes(rawValue: getSettings(type: .SEARCH_LOCATION) ?? LocationFilterTypes.all.rawValue) ?? LocationFilterTypes.all
    }

    func setUserInfo(user: UserInfo?) {
        if user != nil {
            setSettings(type: .USER_THUMB_PHOTO, value: user?.getMainPhoto()?.thumb_url ?? "")
            setSettings(type: .USER, value: Kson.shared.toJson(value: user) ?? "")
            setSettings(type: .SENT_MESSAGES_TODAY, value: user?.sent_messages_today ?? 0)
            setSettings(type: .SENT_INVITATIONS_TODAY, value: user?.sent_invitations_today ?? 0)
            setSettings(type: .ID, value: user?.id ?? 0)
        }
    }

    func getUserId() -> Int {
        getSettings(type: .ID)
    }

    func getUserThumbUrl() -> String {
        getSettings(type: .USER_THUMB_PHOTO) ?? ""
    }

    func getUser() -> UserInfo {
        let jsonString = getSettings(type: .USER) ?? ""
        if jsonString.isEmpty { return UserInfo() }
        return Kson.shared.fromJson(json: jsonString, type: UserInfo.self) ?? UserInfo()
    }

    func clearUserData() {
        setSettings(type: .ACCESS_TOKEN, value: "")
        setSettings(type: .REFRESH_TOKEN, value: "")
        setSettings(type: .USER_THUMB_PHOTO, value: "")
        setSettings(type: .USER, value: "")
        setSettings(type: .ID, value: 0)
    }

    func setAppSettings(appSettings: AppSettings?) {
        if appSettings != nil {
            setSettings(type: .SUBSCRIBTION_MODE_ACTIVE, value: appSettings?.subscription == true)
            setSettings(type: .FREE_MESSAGES, value: appSettings?.free_messages_count ?? 0)
            setSettings(type: .FREE_INVITATIONS, value: appSettings?.free_invitations_count ?? 0)
        }
    }

    func setSentMessagesCount(count: Int) {
        setSettings(type: .SENT_MESSAGES_TODAY, value: count)
    }

    func setSentInvitationsCount(count: Int) {
        setSettings(type: .SENT_INVITATIONS_TODAY, value: count)
    }

    func messageSendAllowed() -> Bool {
        return getUser().gender == "male" &&
        getSettings(type: .SUBSCRIBTION_MODE_ACTIVE) &&
        !hasAActiveSubscription() ?
        (getSettings(type: .SENT_MESSAGES_TODAY) < getSettings(type: .FREE_MESSAGES))
        : true
    }

    func invitationSendAllowed() -> Bool {
        return getUser().gender == "male" &&
        getSettings(type: .SUBSCRIBTION_MODE_ACTIVE) &&
        !hasAActiveSubscription() ?
        (getSettings(type: .SENT_INVITATIONS_TODAY) < getSettings(type: .FREE_INVITATIONS))
        : true
    }

    func hideGuests() -> Bool {
        getUser().gender == "male" &&
        getSettings(type: .SUBSCRIBTION_MODE_ACTIVE) &&
        !hasAActiveSubscription()
    }

    func setActiveSubscription(active: Bool) {
        setSettings(type: .ACTIVE_SUBSCRIPTION, value: active)
    }

    func setActiveAndroidSubscription(endDate: String) {
        setSettings(type: .ACTIVE_ANDROID_SUBSCRIPTION, value: endDate > Date().toLongServerDate())
    }

    func hasAActiveSubscription() -> Bool {
        getSettings(type: .ACTIVE_SUBSCRIPTION) || getSettings(type: .ACTIVE_ANDROID_SUBSCRIPTION)
    }

    func setMatchesEnabled(enabled: Bool) {
        setSettings(type: .MATCHES_ENABLED, value: enabled)
        MatchMediator.shared.matchesEnabled = enabled
    }

    func getMatchesEnabled() -> Bool {
        getSettings(type: .MATCHES_ENABLED)
    }

    func setChatEnabled(enabled: Bool) {
        setSettings(type: .CHAT_ENABLED, value: enabled)
        ChatMediator.shared.chatEnabled = enabled
    }

    func getChatEnabled() -> Bool {
        getSettings(type: .CHAT_ENABLED)
    }
}

class UserDefaultsUtil {
    func getSettings(type: HolderTypes) -> String? {
        UserDefaults.standard.string(forKey: type.rawValue)
    }

    func getSettings(type: HolderTypes) -> Bool {
        UserDefaults.standard.bool(forKey: type.rawValue)
    }

    func getSettings(type: HolderTypes) -> Int {
        UserDefaults.standard.integer(forKey: type.rawValue)
    }

    func setSettings(type: HolderTypes, value: String) {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(value, forKey: type.rawValue)
        }
    }

    func setSettings(type: HolderTypes, value: Bool) {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(value, forKey: type.rawValue)
        }
    }

    func setSettings(type: HolderTypes, value: Int) {
        DispatchQueue.main.async {
            UserDefaults.standard.setValue(value, forKey: type.rawValue)
        }
    }
}

enum HolderTypes: String {
    case ACCESS_TOKEN
    case REFRESH_TOKEN
    case NOTIFICATION_TOKEN
    case START_SCREEN
    case SEARCH_LOCATION
    case SEARCH_ONLINE
    case USER_THUMB_PHOTO
    case USER
    case SUBSCRIBTION_MODE_ACTIVE
    case FREE_MESSAGES
    case FREE_INVITATIONS
    case SENT_MESSAGES_TODAY
    case SENT_INVITATIONS_TODAY
    case ID
    case MATCHES_ENABLED
    case CHAT_ENABLED
    case ACTIVE_SUBSCRIPTION
    case ACTIVE_ANDROID_SUBSCRIPTION
}
