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
        case .navigate(screen: let screen):
            state.inProcess = false
            state.screenStack.append(state.activeScreen)
            state.activeScreen = screen

        case .navigationBack: do {
            let lastScreen = state.screenStack.last
            if (lastScreen != nil) {
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

        case .show(message: let message, screen: let screen):
            state.inProcess = false
            state.notificationText = message
            state.showMessage.toggle()
            if (screen != nil) { state.activeScreen = screen ?? .ONBOARD_START }

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
            
        }
        
        return state
    }

}