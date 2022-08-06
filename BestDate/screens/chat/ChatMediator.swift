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

    @Published var inputText: String = ""

    @Published var editMode: Bool = false
    @Published var replyMode: Bool = false

    func setUser(user: ShortUserInfo) {
        self.user = user
        self.getMessageList()
    }

    func setUser(user: UserInfo) {
        self.setUser(user: user.toShortUser())
    }

    func saveMessage(message: String, completion: @escaping (Bool) -> Void) {
        if editMode {
            editMessage(newMessage: message) { success in completion(success) }
        } else {
            sendMessage(message: message) { success in completion(success) }
        }
    }

    func sendMessage(message: String, completion: @escaping (Bool) -> Void) {
        ChatApiService.shared.sendTextMessage(userId: user.id ?? 0, parentId: selectedMessage?.id, message: message) { success, savedMessage in
            DispatchQueue.main.async {
                if success {
                    self.messages.add(message: savedMessage)
                    withAnimation {
                        self.replyMode = false
                        self.editMode = false
                    }
                }
                completion(success)
            }
        }
    }

    func editMessage(newMessage: String, completion: @escaping (Bool) -> Void) {
        ChatApiService.shared.updateMessage(id: selectedMessage?.id ?? 0, message: newMessage) { success, message in
            DispatchQueue.main.async {
                if success {
                    self.messages.update(message: message)
                    withAnimation {
                        self.replyMode = false
                        self.editMode = false
                    }
                }
                completion(success)
            }
        }
    }

    func sendImageMessage(image: UIImage, message: String?, completion: @escaping (Bool) -> Void) {
        ImageUtils.resizeForChat(image: image) { newImage in
            ImagesApiService.shared.sendImageMessage(image: newImage, userId: self.user.id ?? 0, parentId: self.selectedMessage?.id, message: message) { success, message in
                DispatchQueue.main.async {
                    if success {
                        self.messages.add(message: message)
                        withAnimation {
                            self.replyMode = false
                            self.editMode = false
                        }
                    }
                    completion(success)
                }
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
        withAnimation {
            self.editMode = true
            self.replyMode = false
            self.inputText = selectedMessage?.text ?? ""
        }
    }

    func reply() {
        withAnimation {
            self.replyMode = true
            self.editMode = false
        }
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
