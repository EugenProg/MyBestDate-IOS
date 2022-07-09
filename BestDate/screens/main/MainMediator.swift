//
//  MainMediator.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import Foundation
import UIKit

class MainMediator: ObservableObject {
    static let shared = MainMediator()

    @Published var currentScreen: MainScreensType = .SEARCH
    @Published var hasNewMessages: Bool = true
    @Published var hasNewGuests: Bool = false
}

enum MainScreensType {
    case SEARCH
    case MATCHES
    case CHAT_LIST
    case TOP_50
    case GUESTS

    static let width = UIScreen.main.bounds.width

    var offset: CGFloat {
        switch self {
        case .SEARCH: return MainScreensType.width * 2
        case .MATCHES: return MainScreensType.width
        case .CHAT_LIST: return 0
        case .TOP_50: return -MainScreensType.width
        case .GUESTS: return -(MainScreensType.width * 2)
        }
    }
}
