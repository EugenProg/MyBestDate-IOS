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

    @Published var user: ShortUserInfo? = ShortUserInfo()
    @Published var messages: [ChatItem] = []
    @Published var selectedMessage: Message? = nil
    @Published var meta: Meta = Meta()

    @Published var inputText: String = ""

    @Published var editMode: Bool = false
    @Published var replyMode: Bool = false
    @Published var loadingMode: Bool = false

    @Published var editImageMode: Bool = false
    @Published var selectedImage: UIImage? = nil

    @Published var cardsOnlyMode: Bool = false
    @Published var isOnline: Bool = false
    @Published var typingMode: Bool = false
    @Published var ping: Int = 0
    @Published var chatEnabled: Bool = UserDataHolder.shared.getChatEnabled()

    var showMessage: ((String) -> Void)? = nil

    var origionalList: [Message] = []
    var typingIventSent: Bool = false
    var lastTypingUpdate: Int64 = Int64(Date().timeIntervalSince1970)
    var lastInputUpdate: Int64 = Int64(Date().timeIntervalSince1970)

    private var cancellableSet: Set<AnyCancellable> = []
    private var inputCancelableSet: Set<AnyCancellable> = []

    func setUser(user: ShortUserInfo) {
        CreateInvitationMediator.shared.getInvitations()
        self.user = user
        self.sendReadingEvent(recepientId: user.id)
        self.getMessageList(withClear: true, page: 0)
        self.initInputListener()
        self.initTypingListener()
        self.isOnline = user.is_online == true
    }

    func initInputListener() {
        $inputText
            .sink { (_) in
            } receiveValue: { _ in
                if self.getTimeIntervale(interval: self.lastInputUpdate) > 3 || self.inputText.count == 1 {
                    if !self.inputText.isEmpty && !self.typingIventSent {
                        self.typingIventSent = true
                        ChatApiService.shared.sendTypingEvent(recepient: self.user?.id ?? 0) {
                            DispatchQueue.main.async {
                                self.typingIventSent = false
                            }
                        }
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
        ChatApiService.shared.sendTextMessage(userId: user?.id ?? 0, parentId: parentId, message: message) { success, savedMessage in
            DispatchQueue.main.async {
                if success {
                    self.addMessage(message: savedMessage)

                    ChatListMediator.shared.setNewMessage(message: savedMessage)
                }
                completion(success)
            }
        }
    }

    func addMessage(message: Message) {
        if self.messages.last?.message?.id != message.id {
            withAnimation {
                self.messages.add(message: message)
                self.replyMode = false
                self.editMode = false
                self.selectedMessage = nil
            }
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

                ChatListMediator.shared.setNewMessage(message: message)
                completion(success)
            }
        }
    }

    func sendImageMessage(image: UIImage, message: String?, completion: @escaping (Bool) -> Void) {
        let parentId = replyMode ? selectedMessage?.id ?? 0 : nil
        ImageUtils.resizeForChat(image: image) { newImage in
            ImagesApiService.shared.sendImageMessage(image: newImage, userId: self.user?.id ?? 0, parentId: parentId, message: message) { success, message in
                DispatchQueue.main.async {
                    if success {
                        withAnimation {
                            self.messages.add(message: message)
                            self.replyMode = false
                            self.editMode = false
                            self.selectedMessage = nil
                        }
                    }

                    ChatListMediator.shared.setNewMessage(message: message)
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
        TranslateTextApiService.shared.translate(text: text, lang: user?.language ?? "en") { success, translatedText in
            completion(success, translatedText)
        }
    }

    func translateMessage(message: Message?) {
        TranslateTextApiService.shared.translate(text: message?.text ?? "", lang: UserDataHolder.shared.getUser().language ?? "en") { success, translatedText in
            DispatchQueue.main.async {
                withAnimation {
                    if success {
                        self.messages.update(message: message?.setTranslatedText(text: translatedText) ?? Message())
                    } else {
                        self.messages.update(message: message ?? Message())
                    }
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

    func copy() {
        UIPasteboard.general.string = selectedMessage?.text ?? ""
        if showMessage != nil {
            showMessage!("message_is_copied_to_clipboard".localized())
        }
    }

    func doActionByType(type: ChatActions) {
        switch type {
        case .edit: editMessage()
        case .delete: deleteMessage()
        case .reply: reply()
        case .copy: copy()
        }
    }

    func isMyMessage() -> Bool {
        selectedMessage?.sender_id != user?.id
    }

    func getMessageList(withClear: Bool, page: Int) {
        if self.loadingMode { return }
        self.loadingMode = true
        ChatApiService.shared.getChatMessages(userId: user?.id ?? 0, page: page) { success, list, meta in
            DispatchQueue.main.async {
                if success {
                    self.origionalList.addAll(list: list, clear: withClear)
                    self.meta = meta

                    withAnimation {
                        self.messages = ChatUtils().getChatItemsFromMessages(messageList: self.origionalList)
                    }
                }
                self.cardsOnlyMode = self.user?.allow_chat == false
                self.loadingMode = false
            }
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getMessageList(withClear: false, page: (meta.current_page ?? 0) + 1)
    }

    func sendReadingEvent(recepientId: Int?) {
        ChatApiService.shared.sendReadEvent(recepient: recepientId ?? 0)
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
