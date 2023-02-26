//
//  Action.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import SwiftUI

enum Action {
    case navigate(screen: ScreenList, clearBackStack: Bool? = nil)
    case showBottomSheet(view: BottomSheetList)
    case hideBottomSheet
    case navigationBack
    case openLink(link: String)
    case show(message: String)
    case startProcess
    case endProcess
    case setStatusbarColor(color: Color)
    case setScreenColors(status: Color, style: UIStatusBarStyle)
    case hideKeyboard
    case createInvitation
    case matchAction
    case hasADeepLink
    case showPushNotification(type: NotificationType)
    case showDeleteDialog
    case showLanguageSettingDialog
    case showSetPermissionDialog
    case showMessageBunningDialog
    case showInvitationBunningDialog
}
