//
//  PushMediator.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import Foundation

class PushMediator: ObservableObject {
    static var shared = PushMediator()

    @Published var user: ShortUserInfo? = nil
    @Published var body: String? = nil
    @Published var title: String? = nil

    func setUser(user: ShortUserInfo?) {
        self.user = user
    }

    func setDefaultMessage(body: String, title: String) {
        self.body = body
        self.title = title
    }
}

enum NotificationType: String {
    case defaultPush
    case like
    case match
    case invitation
    case message
    case guest

    static func getNotificationType(type: String) -> NotificationType {
        switch type {
        case "like": return .like
        case "match": return .match
        case "invitation": return .invitation
        case "message": return .message
        case "guest": return .guest
        default: return .defaultPush
        }
    }
}
