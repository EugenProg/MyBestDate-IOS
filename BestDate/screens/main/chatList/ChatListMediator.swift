//
//  ChatListMediator.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import Foundation

class ChatListMediator: ObservableObject {
    static var shared = ChatListMediator()

    @Published var newChats: [Chat] = []
    @Published var previousChats: [Chat] = []
    @Published var loadingMode: Bool = true

    func getChatList() {
        loadingMode = true
        ChatApiService.shared.getChatList { success, chatList in
            DispatchQueue.main.async {
                if success {
                    self.newChats.removeAll()
                    self.previousChats.removeAll()
                    for index in chatList.indices {
                        var chat = chatList[index]
                        chat.id = index
                        if chat.last_message?.read_at == nil &&
                            chat.last_message?.sender_id != MainMediator.shared.user.id {
                            self.newChats.append(chat)
                        } else {
                            self.previousChats.append(chat)
                        }
                    }
                    MainMediator.shared.hasNewMessages = self.newChats.count > 0
                }
                self.loadingMode = false
            }
        }
    }

    func delete(chat: Chat, completion: @escaping () -> Void) {
        ChatApiService.shared.deleteChat(id: chat.user?.id ?? 0) { success in
            DispatchQueue.main.async {
                if success {
                    self.getChatList()
                    completion()
                }
            }
        }
    }
}
