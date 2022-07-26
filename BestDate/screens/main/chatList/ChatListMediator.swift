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

    func getChatList() {
        ChatApiService.shared.getChatList { success, chatList in
            DispatchQueue.main.async {
                if success {
                    self.newChats.removeAll()
                    self.previousChats.removeAll()
                    for chat in chatList {
                        if chat.last_message == nil {
                            self.newChats.append(chat)
                        } else {
                            self.previousChats.append(chat)
                        }
                    }
                }
            }
        }
    }
}
