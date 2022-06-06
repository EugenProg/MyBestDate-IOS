//
//  AppState.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import SwiftUI

struct AppState {
    var activeScreen: ScreenList = ScreenList.SPLASH_SCREEN
    var screenStack: [ScreenList] = []
    var showMessage: Bool = false
    var notificationText: String = ""
    var inProcess: Bool = false
    var statusBarColor: Color = ColorList.white.color
    var statusBarHeight: CGFloat = 0.0
}
