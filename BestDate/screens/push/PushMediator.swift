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

    func setUser(jsonString: String) {
        if jsonString.isEmpty { return }

        let user = try? JSONDecoder().decode(ShortUserInfo.self, from: jsonString.data(using: .utf8)!)

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

    static func getNotificationType(type: String) -> NotificationType {
        switch type {
        case "like": return .like
        case "match": return .match
        case "invitation": return .invitation
        default: return .defaultPush
        }
    }
}
