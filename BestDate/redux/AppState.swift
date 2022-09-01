//
//  AppState.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import SwiftUI

struct AppState {
    var activeScreen: ScreenList = ScreenList.START
    var activeBottomSheet: BottomSheetList = BottomSheetList.GENDER
    var activePush: NotificationType = NotificationType.defaultPush
    var showBottomSheet: Bool = false
    var screenStack: [ScreenList] = []
    var showMessage: Bool = false
    var notificationText: String = ""
    var inProcess: Bool = false
    var statusBarColor: Color = ColorList.white.color
    var statusBarHeight: CGFloat = 0.0
    var showInvitationDialog: Bool = false
    var showMatchActionDialog: Bool = false
    var hasADeepLink: Bool = false
    var showPushNotification: Bool = false
}
