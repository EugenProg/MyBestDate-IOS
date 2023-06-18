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
    case invitation_answer
    case message
    case guest
    case moderation_success
    case moderation_failure

    static func getNotificationType(type: String) -> NotificationType {
        switch type {
        case "like": return .like
        case "match": return .match
        case "invitation": return .invitation
        case "invitation_answer": return .invitation_answer
        case "message": return .message
        case "guest": return .guest
        case "photo_failed": return .moderation_failure
        case "photo_success": return .moderation_success
        default: return .defaultPush
        }
    }
}
