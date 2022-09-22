//
//  SettingsMediator.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import Foundation
import SwiftUI

class SettingsMediator: ObservableObject {
    static var shared = SettingsMediator()

    @Published var language: String = NSLocalizedString("app_lang", comment: "Localisation")
    @Published var settings: UserSettings = UserSettings()

    func getUserSettings() {
        CoreApiService.shared.getUserSettings { success, settings in
            DispatchQueue.main.async {
                withAnimation { self.settings = settings }
            }
        }
    }

    func saveSettings(type: UserSettingsType, enable: Bool, completion: @escaping () -> Void) {
        CoreApiService.shared.saveSettings(model: type.requestBody(enable: enable)) { success in
            completion()
        }
    }

    func updateLanguage(enable: Bool, completion: @escaping () -> Void) {
        CoreApiService.shared.updateLanguage(enable: enable) { success in
            completion()
        }
    }
}

enum UserSettingsType {
    case messages
    case notify_likes
    case notify_matches
    case notify_invitations
    case notify_messages
    case notify_guests
    case matches

    func requestBody(enable: Bool) -> SaveSettingsRequest {
        switch self {
        case .messages: return SaveSettingsRequest(block_messages: enable)
        case .notify_likes: return SaveSettingsRequest(likes_notifications: enable)
        case .notify_matches: return SaveSettingsRequest(matches_notifications: enable)
        case .notify_invitations: return SaveSettingsRequest(invitations_notifications: enable)
        case .notify_messages: return SaveSettingsRequest(messages_notifications: enable)
        case .notify_guests: return SaveSettingsRequest(guests_notifications: enable)
        case .matches: return SaveSettingsRequest(matches: enable)
        }
    }
}
