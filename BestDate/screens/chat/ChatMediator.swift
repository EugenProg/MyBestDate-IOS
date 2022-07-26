//
//  ChatMediator.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import Foundation

class ChatMediator: ObservableObject {
    static var shared = ChatMediator()

    @Published var user: ShortUserInfo = ShortUserInfo()

    func setUser(user: ShortUserInfo) {
        self.user = user
    }

    func setUser(user: UserInfo) {
        self.user = user.toShortUser()
    }
}

struct ChatItem {
    var id: Int
    var messageType: ChatViewType
    var message: Message? = nil
    var date: Date? = nil
}

enum ChatViewType {
    case my_text_message
    case my_text_message_with_parent
    case my_voice_message
    case my_voice_message_with_parent
    case my_image_message
    case my_image_message_with_parent

    case user_text_message
    case user_text_message_with_parent
    case user_voice_message
    case user_voice_message_with_parent
    case user_image_message
    case user_image_message_with_parent

    case date_block
}
