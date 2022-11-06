//
//  PusherMediator.swift
//  BestDate
//
//  Created by Евгений on 16.10.2022.
//

import Foundation
import PusherSwift

class PusherMediator {
    static var shared: PusherMediator = PusherMediator()

    private var pusher: Pusher? = nil
    private var chatChannel: PusherChannel? = nil
    private var userChannel: PusherChannel? = nil
    private var store: Store? = nil

    func startPusher() {
        if !isConnected() {
            self.createConnection()
            let chatChannelName = "private-chat.\(MainMediator.shared.user.id ?? 0)"
            let userChannelName = "private-user.\(MainMediator.shared.user.id ?? 0)"
            self.chatChannel = pusher?.subscribe(chatChannelName)
            self.userChannel = pusher?.subscribe(userChannelName)
            self.listener()
        }
    }

    func setStore(store: Store) {
        self.store = store
    }

    private func createConnection() {
        let options = PusherClientOptions(host: .cluster("eu"))
        options.setAuthMethod(authMethod: OCAuthMethod(authRequestBuilder: AuthRequestBuilder()))

        pusher = Pusher(key: "d995b7146329bb8422f3", options: options)
        pusher?.connect()
        pusher?.delegate = self
    }

    private func listener() {
        messageListener()
        editListener()
        readListener()
        deleteListener()
        typingListener()
        coinsListener()
    }


    private func messageListener() {
        chatChannel?.bind(eventName: "private-message", eventCallback: { event in
            MainMediator.shared.hasNewMessages = true

            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
                ChatMediator.shared.addMessage(message: message ?? Message())
                ChatApiService.shared.sendReadEvent(recepient: message?.sender_id ?? 0)
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func editListener() {
        chatChannel?.bind(eventName: "private-update", eventCallback: { event in
            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
                self.editMessage(message: message)
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func editMessage(message: Message?) {
        var newList: [ChatItem] = []
        for item in ChatMediator.shared.messages {
            if item.message?.id == message?.id {
                newList.append(
                    ChatItem(
                        id: item.id,
                        messageType: item.messageType,
                        message: message,
                        last: item.last,
                        date: item.date
                    )
                )
            } else {
                newList.append(item)
            }
        }

        ChatMediator.shared.messages = newList
    }

    private func deleteListener() {
        chatChannel?.bind(eventName: "private-delete", eventCallback: { event in
            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
                ChatMediator.shared.messages.delete(id: message?.id)
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func readListener() {
        chatChannel?.bind(eventName: "private-read", eventCallback: { event in
            let message = self.parceReadMessageData(event: event)

            if self.isInTheChat(id: message?.recipient_id) {
                self.editMessage(message: message)
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func typingListener() {
        chatChannel?.bind(eventName: "private-typing", eventCallback: { event in
            let senderId = self.parceTypingEventData(event: event)

            if self.isInTheChat(id: senderId) {
                ChatMediator.shared.setTypingMode()
            } else if self.inTheChatList() {
                ChatListMediator.shared.setTypingEvent(userId: senderId ?? 0)
            }
        })
    }

    private func coinsListener() {
        userChannel?.bind(eventName: "private-coins", eventCallback: { event in
            let coinsCount = self.parceCoinsEventData(event: event)

            if coinsCount > 0 {
                MainMediator.shared.coinsCount = coinsCount
            }
        })
    }

    private func parceCoinsEventData(event: PusherEvent) -> Int {
        if event.data != nil {
            let jsonData = event.data?.replacingOccurrences(of: "\\\"", with: "\"") ?? ""
            let coinsObject = try? JSONDecoder().decode(CoinsEventResponse.self, from: jsonData.data(using: .unicode)!)

            return coinsObject?.coins.toInt() ?? 0
        }
        return -1
    }

    private func parceTypingEventData(event: PusherEvent) -> Int? {
        if event.data != nil {
            let jsonData = event.data?.replacingOccurrences(of: "\\\"", with: "\"") ?? ""
            let typingObject = try? JSONDecoder().decode(TypingEventResponse.self, from: jsonData.data(using: .unicode)!)

            return typingObject?.sender_id
        }
        return nil
    }

    private func parceMessageData(event: PusherEvent) -> Message? {
        if event.data != nil {
            let jsonData = event.data?.replacingOccurrences(of: "\\\"", with: "\"") ?? ""
            let messageObject = try? JSONDecoder().decode(SocketMessage.self, from: jsonData.data(using: .unicode)!)

            return messageObject?.message
        }
        return nil
    }

    private func parceReadMessageData(event: PusherEvent) -> Message? {
        if event.data != nil {
            let jsonData = event.data?.replacingOccurrences(of: "\\\"", with: "\"") ?? ""
            let messageObject = try? JSONDecoder().decode(ReadMessage.self, from: jsonData.data(using: .unicode)!)

            return messageObject?.last_message
        }
        return nil
    }

    func isInTheChat(id: Int?) -> Bool {
        return self.store?.state.activeScreen == .CHAT && id == ChatMediator.shared.user.id
    }

    func inTheChatList() -> Bool {
        self.store?.state.activeScreen == .MAIN && MainMediator.shared.currentScreen == .CHAT_LIST
    }

    func isConnected() -> Bool {
        pusher?.connection.connectionState == .connected
    }

    func closePusherConnection() {
        pusher?.unbindAll()
        pusher?.disconnect()
        print(">>> Stop connection")
    }
}

class AuthRequestBuilder: AuthRequestBuilderProtocol {
    func requestFor(socketID: String, channelName: String) -> URLRequest? {
        let url = URL(string: "https://dev-api.bestdate.info/broadcasting/auth")!
        var request = URLRequest(url: url)
        request.setValue(UserDataHolder.accessToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = "socket_id=\(socketID)&channel_name=\(channelName)".data(using: String.Encoding.utf8)
        return request
    }
}

extension PusherMediator: PusherDelegate {
    func debugLog(message: String) {
        print(message)
    }

    func subscribedToChannel(name: String) {
        print(">>> Subscribed to \(name)")
    }

    func receivedError(error: PusherError) {
        let message = error.message
        if error.code != nil {
            print(">>> error: \(message)")
        }
    }
}
