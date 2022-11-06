//
//  UserDataHolder.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class UserDataHolder {

    private(set) static var accessToken: String = getSettings(type: .ACCESS_TOKEN) ?? ""
    private(set) static var refreshToken: String = getSettings(type: .REFRESH_TOKEN) ?? ""
    private(set) static var notificationToken: String = getSettings(type: .NOTIFICATION_TOKEN) ?? ""
    private(set) static var startScreen: ScreenList = ScreenList(rawValue: getSettings(type: .START_SCREEN) ?? ScreenList.START.rawValue) ?? ScreenList.START
    private(set) static var searchOnline: OnlineFilterTypes = OnlineFilterTypes(rawValue: getSettings(type: .SEARCH_ONLINE) ?? OnlineFilterTypes.all.rawValue) ?? OnlineFilterTypes.all
    private(set) static var searchLocation: LocationFilterTypes = LocationFilterTypes(rawValue: getSettings(type: .SEARCH_LOCATION) ?? LocationFilterTypes.all.rawValue) ?? LocationFilterTypes.all

    static func setAuthData(response: AuthResponse) {
        accessToken = "Bearer \(response.access_token ?? "")"
        setSettings(type: .ACCESS_TOKEN, value: accessToken)

        refreshToken = response.refresh_token ?? ""
        setSettings(type: .REFRESH_TOKEN, value: refreshToken)
    }

    static func setNotificationToken(token: String?) {
        if token != nil {
            notificationToken = token!
            setSettings(type: .NOTIFICATION_TOKEN, value: token!)
        }
    }

    static func setStartScreen(screen: ScreenList) {
        startScreen = screen
        setSettings(type: .START_SCREEN, value: screen.rawValue)
    }

    static func setSearchOnline(filter: OnlineFilterTypes) {
        searchOnline = filter
        if filter == .filter {
            setSettings(type: .SEARCH_ONLINE, value: OnlineFilterTypes.all.rawValue)
        } else {
            setSettings(type: .SEARCH_ONLINE, value: filter.rawValue)
        }
    }

    static func setSearchLocation(filter: LocationFilterTypes) {
        searchLocation = filter
        if filter == .filter {
            setSettings(type: .SEARCH_LOCATION, value: LocationFilterTypes.all.rawValue)
        } else {
            setSettings(type: .SEARCH_LOCATION, value: filter.rawValue)
        }
    }

    private static func getSettings(type: HolderTypes) -> String? {
        UserDefaults.standard.string(forKey: type.rawValue)
    }

    private static func setSettings(type: HolderTypes, value: String) {
        UserDefaults.standard.setValue(value, forKey: type.rawValue)
    }
}

enum HolderTypes: String {
    case ACCESS_TOKEN
    case REFRESH_TOKEN
    case NOTIFICATION_TOKEN
    case START_SCREEN
    case SEARCH_LOCATION
    case SEARCH_ONLINE
}
