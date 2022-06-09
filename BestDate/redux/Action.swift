//
//  Action.swift
//  BestDate
//
//  Created by Евгений on 05.06.2022.
//

import Foundation
import SwiftUI

enum Action {
    case navigate(screen: ScreenList)
    case navigationBack
    case openLink(link: String)
    case show(message: String)
    case startProcess
    case endProcess
    case setStatusbarColor(color: Color)
    case setScreenColors(status: Color, style: UIStatusBarStyle)
}
