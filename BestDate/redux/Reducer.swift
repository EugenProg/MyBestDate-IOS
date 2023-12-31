//
//  Reducer.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import SwiftUI

final class Reducer {
    func reducer(state: AppState, action: Action) -> AppState {
        var state = state
        
        switch action {
        case .navigate(screen: let screen, clearBackStack: let clear):
            if screen != state.activeScreen {
                print(">> Navigation -> \(screen.rawValue)")
                state.inProcess = false
                state.screenStack.append(state.activeScreen)
                if (clear == true) { state.screenStack.removeAll() }
                state.activeScreen = screen
            }

        case .navigationBack: do {
            let lastScreen = state.screenStack.last
            if (lastScreen != nil && lastScreen != .START) {
                state.activeScreen = state.screenStack.last!
                state.screenStack.removeLast()
            }
            state.inProcess = false
        }

        case .openLink(link: let link):
            if let url = URL(string: link) {
                if UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }

        case .show(message: let message):
            state.inProcess = false
            state.notificationText = message
            state.showMessage.toggle()

        case .startProcess: do {
            state.inProcess = true
        }

        case .endProcess:
            state.inProcess = false
            
        case .setScreenColors(status: let statusColor, style: let style): do {
            state.statusBarColor = statusColor
            UIApplication.shared.statusBarStyle = style
            state.statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
            
        case .setStatusbarColor(color: let color):
            state.statusBarColor = color
            
        case .showBottomSheet(view: let sheet): do {
            state.activeBottomSheet = sheet
            state.showBottomSheet = true
        }
            
        case .hideBottomSheet:
            state.showBottomSheet = false

        case .hideKeyboard:
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)

        case .createInvitation:
            state.showInvitationDialog = true

        case .matchAction:
            state.showMatchActionDialog = true

        case .hasADeepLink:
            state.hasADeepLink = true

        case .showPushNotification(type: let notificationType): do {
            state.activePush = notificationType
            state.showPushNotification = true
        }

        case .showDeleteDialog:
            state.showDeleteDialog = true

        case .showLanguageSettingDialog:
            state.showLanguageSettingDialog = true

        case .showSetPermissionDialog:
            state.showSetPermissionDialog = true

        case .showMessageBunningDialog:
            state.showMessageBunningDialog = true

        case .showInvitationBunningDialog:
            state.showInvitationBunningDialog = true
        }
        
        return state
    }

}
