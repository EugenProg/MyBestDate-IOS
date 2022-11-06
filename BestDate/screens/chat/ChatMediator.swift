//
//  ChatMediator.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class ChatMediator: ObservableObject {
    static var shared = ChatMediator()

    @Published var user: ShortUserInfo = ShortUserInfo()
    @Published var messages: [ChatItem] = []
    @Published var selectedMessage: Message? = nil

    @Published var inputText: String = ""

    @Published var editMode: Bool = false
    @Published var replyMode: Bool = false
    @Published var loadingMode: Bool = true

    @Published var editImageMode: Bool = false
    @Published var selectedImage: UIImage? = nil

    @Published var cardsOnlyMode: Bool = false
    @Published var isOnline: Bool = false
    @Published var typingMode: Bool = false
    @Published var ping: Int = 0
    var lastTypingUpdate: Int64 = Int64(Date().timeIntervalSince1970)
    var lastInputUpdate: Int64 = Int64(Date().timeIntervalSince1970)

    private var cancellableSet: Set<AnyCancellable> = []
    private var inputCancelableSet: Set<AnyCancellable> = []

    func setUser(user: ShortUserInfo) {
        CreateInvitationMediator.shared.getInvitations()
        self.user = user
        self.getMessageList()
        self.initInputListener()
        self.initTypingListener()
        self.isOnline = user.is_online == true
    }

    func initInputListener() {
        $inputText
            .sink { (_) in
            } receiveValue: { _ in
                if self.getTimeIntervale(interval: self.lastInputUpdate) > 3 || self.inputText.count == 1 {
                    if !self.inputText.isEmpty {
                        ChatApiService.shared.sendTypingEvent(recepient: self.user.id ?? 0)
                    }
                    self.lastInputUpdate = Int64(Date().timeIntervalSince1970)
                }
            }
            .store(in: &inputCancelableSet)
    }

    func setTypingMode() {
        self.typingMode = true
        self.ping += 1
        self.lastTypingUpdate = Int64(Date().timeIntervalSince1970)
        self.isOnline = true
    }

    private func getTimeIntervale(interval: Int64) -> Int {
        Int(Int64(Date().timeIntervalSince1970) - interval)
    }

    func initTypingListener() {
        $ping
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { (_) in
            } receiveValue: { _ in
                if self.getTimeIntervale(interval: self.lastTypingUpdate) > 3 &&
                    self.typingMode == true {
                    self.typingMode = false
                } else if self.typingMode == true {
                    self.ping += 1
                } else if self.ping > 1234 {
                    self.ping = 0
                }
            }
            .store(in: &cancellableSet)
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
        let parentId = replyMode ? selectedMessage?.id : nil
        ChatApiService.shared.sendTextMessage(userId: user.id ?? 0, parentId: parentId, message: message) { success, savedMessage in
            DispatchQueue.main.async {
                if success {
                    self.addMessage(message: savedMessage)
                }
                completion(success)
            }
        }
    }

    func addMessage(message: Message) {
        withAnimation {
            self.messages.add(message: message)
            self.replyMode = false
            self.editMode = false
            self.selectedMessage = nil
        }
    }

    func editMessage(newMessage: String, completion: @escaping (Bool) -> Void) {
        ChatApiService.shared.updateMessage(id: selectedMessage?.id ?? 0, message: newMessage) { success, message in
            DispatchQueue.main.async {
                if success {
                    withAnimation {
                        self.messages.update(message: message)
                        self.replyMode = false
                        self.editMode = false
                        self.selectedMessage = nil
                    }
                }
                completion(success)
            }
        }
    }

    func sendImageMessage(image: UIImage, message: String?, completion: @escaping (Bool) -> Void) {
        let parentId = replyMode ? selectedMessage?.id ?? 0 : nil
        ImageUtils.resizeForChat(image: image) { newImage in
            ImagesApiService.shared.sendImageMessage(image: newImage, userId: self.user.id ?? 0, parentId: parentId, message: message) { success, message in
                DispatchQueue.main.async {
                    if success {
                        withAnimation {
                            self.messages.add(message: message)
                            self.replyMode = false
                            self.editMode = false
                            self.selectedMessage = nil
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

    func translate(text: String, completion: @escaping (Bool, String) -> Void) {
        TranslateTextApiService.shared.translate(text: text, lang: user.language ?? "en") { success, translatedText in
            completion(success, translatedText)
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
        loadingMode = true
        ChatApiService.shared.getChatMessages(userId: user.id ?? 0) { success, list in
            DispatchQueue.main.async {
                if success {
                    withAnimation {
                        self.messages.addAll(list: list, clear: true)
                    }
                }
                self.cardsOnlyMode = (self.messages.isEmpty && self.user.block_messages == true) || self.user.allow_chat == false
                self.loadingMode = false
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
