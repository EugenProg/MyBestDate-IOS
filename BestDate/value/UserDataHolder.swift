//
//  UserDataHolder.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class UserDataHolder {

    private(set) static var accessToken: String = getSettings(type: .ACCESS_TOKEN)
    private(set) static  var refreshToken: String = getSettings(type: .REFRESH_TOKEN)

    static func setAuthData(response: AuthResponse) {
        accessToken = "Bearer \(response.access_token)"
        setSettings(type: .ACCESS_TOKEN, value: accessToken)

        refreshToken = response.refresh_token
        setSettings(type: .REFRESH_TOKEN, value: refreshToken)
    }

    private static func getSettings(type: HolderTypes) -> String {
        UserDefaults.standard.string(forKey: type.name) ?? ""
    }

    private static func setSettings(type: HolderTypes, value: String) {
        UserDefaults.standard.setValue(value, forKey: type.name)
    }
}

enum HolderTypes: String {
    case ACCESS_TOKEN
    case REFRESH_TOKEN

    var name: String {
        switch self {
        case .ACCESS_TOKEN: return "ACCESS_TOKEN"
        case .REFRESH_TOKEN: return "REFRESH_TOKEN"
        }
    }
}
