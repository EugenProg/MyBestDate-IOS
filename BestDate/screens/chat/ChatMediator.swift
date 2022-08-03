//
//  ChatMediator.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import Foundation
import UIKit
import SwiftUI

class ChatMediator: ObservableObject {
    static var shared = ChatMediator()

    @Published var user: ShortUserInfo = ShortUserInfo()
    @Published var messages: [ChatItem] = []
    @Published var selectedMessage: Message? = nil

    func setUser(user: ShortUserInfo) {
        self.user = user
        self.getMessageList()
    }

    func setUser(user: UserInfo) {
        self.setUser(user: user.toShortUser())
    }

    func sendMessage(message: String, completion: @escaping (Bool) -> Void) {
        ChatApiService.shared.sendMessage(userId: user.id ?? 0, parentId: selectedMessage?.id, message: message) { success, savedMessage in
            DispatchQueue.main.async {
                if success {
                    self.messages.add(message: savedMessage)
                }
            }
            completion(success)
        }
    }

    func sendImageMessage(image: UIImage, completion: @escaping (Bool) -> Void) {
        ImageUtils.resizeForChat(image: image) { newImage in
            ImagesApiService.shared.sendImageMessage(image: newImage) { success, message in
                DispatchQueue.main.async {
                    if success {
                        self.messages.add(message: message)
                    }
                }
                completion(success)
            }
        }
    }

    func deleteMessage() {
        ChatApiService.shared.deleteMessage(id: selectedMessage?.id ?? 0) { success in
            DispatchQueue.main.async {
                if success {
                    self.messages.delete(id: self.selectedMessage?.id)
                    self.selectedMessage = nil
                }
            }
        }
    }

    func editMessage() {

    }

    func reply() {

    }

    func doActionByType(type: ChatActions) {
        switch type {
        case .edit: editMessage()
        case .delete: deleteMessage()
        case .reply: reply()
        }
    }

    func isMyMessage() -> Bool {
        selectedMessage?.sender_id != user.id
    }

    func getMessageList() {
        ChatApiService.shared.getChatMessages(userId: user.id ?? 0) { success, list in
            DispatchQueue.main.async {
                if success {
                    withAnimation {
                        self.messages.addAll(list: list, clear: true)
                    }
                }
            }
        }
    }
}

struct ChatItem {
    var id: Int
    var messageType: ChatViewType
    var message: Message? = nil
    var last: Bool
    var date: String? = nil
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
