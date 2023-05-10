//
//  ChatListMediator.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import Foundation
import Combine
import UIKit

class ChatListMediator: ObservableObject {
    static var shared = ChatListMediator()

   // @Published var newChats: [ChatListItem] = []
   // @Published var previousChats: [ChatListItem] = []
    @Published var chatList: [ChatListItem] = []
    @Published var lastChatId: Int = 0
    @Published var meta: Meta = Meta()
    private var allChatsList: [Chat] = []
    private var newChatsCount: Int = 0
    @Published var loadingMode: Bool = true
    var typingList: [TypingState] = []
    @Published var ping: Int = 0

    private var cancellableSet: Set<AnyCancellable> = []

    func getChatList(withClear: Bool, page: Int) {
        loadingMode = true
        self.initTypingListener()
        ChatApiService.shared.getChatList(page: page) { success, chatList, meta in
            DispatchQueue.main.async {
                if success {
                    self.allChatsList.addAll(list: chatList, clear: withClear)
                    self.meta = meta
                    self.lastChatId = chatList.last?.user?.id ?? 0
                    self.refillChatsLists()
                    MainMediator.shared.hasNewMessages = self.newChatsCount > 0
                    self.setBadgeCount()
                }
                self.loadingMode = false
            }
        }
    }

    private func setBadgeCount() {
        UIApplication.shared.applicationIconBadgeNumber = self.newChatsCount > 0 ? UserDataHolder.shared.getUser().new_messages ?? 0 : 0
    }

    private func refillChatsLists() {
        //self.newChats.removeAll()
        //self.previousChats.removeAll()
        self.chatList.removeAll()
        self.newChatsCount = 0
        for index in allChatsList.indices {
            var chat = allChatsList[index]
            chat.id = index
            if chat.last_message?.read_at == nil &&
                chat.last_message?.sender_id != UserDataHolder.shared.getUserId() {
                self.newChatsCount += 1
                self.chatList.append(self.getChatListItem(chat: chat, type: ChatItemType.new))
            } else {
                self.chatList.append(self.getChatListItem(chat: chat, type: ChatItemType.old))
            }
        }
    }

    func delete(chat: Chat, completion: @escaping () -> Void) {
        ChatApiService.shared.deleteChat(id: chat.user?.id ?? 0) { success in
            DispatchQueue.main.async {
                if success {
                    self.getChatList(withClear: true, page: 0)
                    completion()
                }
            }
        }
    }

    func setNewMessage(message: Message?) {
        let chatIndex = self.allChatsList.firstIndex { chat in
            chat.user?.id == message?.sender_id || chat.user?.id == message?.recipient_id
        }
        if chatIndex != nil {
            allChatsList[chatIndex!].last_message = message
            allChatsList.sort { first, second in
                (first.last_message?.created_at ?? "") > (second.last_message?.created_at ?? "")
            }
            refillChatsLists()
        } else {
            getChatList(withClear: true, page: 0)
        }
    }

    func setTypingEvent(userId: Int) {
        if typingList.contains(where: { item in item.userId == userId }) {
            let index = typingList.firstIndex { item in item.userId == userId }
            typingList[index ?? 0] = TypingState(userId: userId, lastUpdate: Int64(Date().timeIntervalSince1970))
        } else {
            typingList.append(TypingState(userId: userId, lastUpdate: Int64(Date().timeIntervalSince1970)))
        }
        self.refillChatsLists()
        ping += 1
    }

    func initTypingListener() {
        $ping
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { (_) in
            } receiveValue: { _ in
                self.typingList.forEach { item in
//                    let typingMode = self.newChats.first { chatItem in
//                        chatItem.chat.user?.id == item.userId
//                    }?.typingMode == true || self.previousChats.first { chatItem in
//                        chatItem.chat.user?.id == item.userId
//                    }?.typingMode == true
                    let typingMode = self.chatList.first { chatItem in
                        chatItem.chat.user?.id == item.userId
                    }?.typingMode == true
                    if self.getTimeIntervale(state: item) > 3 && typingMode {
                        self.typingList.removeAll { state in state.userId == item.userId }
                        self.refillChatsLists()
                        if self.typingList.count > 1 { self.ping += 1 }
                    } else if typingMode {
                        self.ping += 1
                    }
                }
                if self.ping > 1234 {
                    self.ping = 0
                }
            }
            .store(in: &cancellableSet)
    }

    func loadNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getChatList(withClear: false, page: (meta.current_page ?? 0) + 1)
    }

    private func getTimeIntervale(state: TypingState) -> Int {
        Int(Int64(Date().timeIntervalSince1970) - state.lastUpdate)
    }

    private func getChatListItem(chat: Chat, type: ChatItemType) -> ChatListItem {
        let typingMode = typingList.contains { item in item.userId == chat.user?.id }
        return ChatListItem(id: chat.id, typingMode: typingMode, isOnline: chat.user?.is_online == true || typingMode, chat: chat, type: type)
    }

    func clearData() {
        //newChats.removeAll()
       // previousChats.removeAll()
        allChatsList.removeAll()
        chatList.removeAll()
    }
}

struct ChatListItem {
    var id: Int? = nil
    var typingMode: Bool = false
    var isOnline: Bool = false
    var chat: Chat
    var type: ChatItemType
}

struct TypingState {
    var userId: Int
    var lastUpdate: Int64
}
