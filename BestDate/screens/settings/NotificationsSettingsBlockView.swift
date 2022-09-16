//
//  MessageSettingsBlockView.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct NotificationsSettingsBlockView: View {
    @ObservedObject var mediator = SettingsMediator.shared
    
    @Binding var settings: NotificationSettings
    @Binding var isEnabled: Bool

    @State var likesSaveProgress: Bool = false
    @State var matchesSaveProgress: Bool = false
    @State var invitationsSaveProgress: Bool = false
    @State var messagesSaveProgress: Bool = false
    @State var guestsSaveProgress: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            SettingsHeaderView(title: "disabling_notifications",
                               description: "you_will_not_receive_notifications")

            SettingsSwitchView(image: "ic_settings_likes",
                               title: "likes",
                               isActive: $settings.likes,
                               saveProgress: $likesSaveProgress,
                               isEnabled: $isEnabled) { checked in
                likesSaveProgress.toggle()
                isEnabled = false
                mediator.saveSettings(type: .notify_likes, enable: checked) {
                    DispatchQueue.main.async {
                        withAnimation { likesSaveProgress.toggle() }
                        isEnabled = true
                    }
                }
            }

            SettingsSwitchView(image: "ic_settings_matches",
                               title: "matches",
                               isActive: $settings.matches,
                               saveProgress: $matchesSaveProgress,
                               isEnabled: $isEnabled) { checked in
                matchesSaveProgress.toggle()
                isEnabled = false
                mediator.saveSettings(type: .notify_matches, enable: checked) {
                    DispatchQueue.main.async {
                        withAnimation { matchesSaveProgress.toggle() }
                        isEnabled = true
                    }
                }
            }

            SettingsSwitchView(image: "ic_settings_invitations",
                               title: "invite_cards",
                               isActive: $settings.invitations,
                               saveProgress: $invitationsSaveProgress,
                               isEnabled: $isEnabled) { checked in
                invitationsSaveProgress.toggle()
                isEnabled = false
                mediator.saveSettings(type: .notify_invitations, enable: checked) {
                    DispatchQueue.main.async {
                        withAnimation { invitationsSaveProgress.toggle() }
                        isEnabled = true
                    }
                }
            }

            SettingsSwitchView(image: "ic_settings_message",
                               title: "messages",
                               isActive: $settings.messages,
                               saveProgress: $messagesSaveProgress,
                               isEnabled: $isEnabled) { checked in
                messagesSaveProgress.toggle()
                isEnabled = false
                mediator.saveSettings(type: .notify_messages, enable: checked) {
                    DispatchQueue.main.async {
                        withAnimation { messagesSaveProgress.toggle() }
                        isEnabled = true
                    }
                }
            }

            SettingsSwitchView(image: "ic_settings_guests",
                               title: "guests",
                               isActive: $settings.guests,
                               saveProgress: $guestsSaveProgress,
                               isEnabled: $isEnabled) { checked in
                guestsSaveProgress.toggle()
                isEnabled = false
                mediator.saveSettings(type: .notify_guests, enable: checked) {
                    DispatchQueue.main.async {
                        withAnimation { guestsSaveProgress.toggle() }
                        isEnabled = true
                    }
                }
            }
        }
    }
}

