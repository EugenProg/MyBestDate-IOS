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
    private var channel: PusherChannel? = nil
    private var store: Store? = nil

    func startPusher() {
        if !isConnected() {
            self.createConnection()
            let channelName = "private-chat.\(MainMediator.shared.user.id ?? 0)"
            self.channel = pusher?.subscribe(channelName)
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
        deleteListener()
    }


    private func messageListener() {
        channel?.bind(eventName: "private-message", eventCallback: { event in
            MainMediator.shared.hasNewMessages = true

            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
                ChatMediator.shared.addMessage(message: message ?? Message())
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func editListener() {
        channel?.bind(eventName: "private-update", eventCallback: { event in
            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
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
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func deleteListener() {
        channel?.bind(eventName: "private-delete", eventCallback: { event in
            let message = self.parceMessageData(event: event)

            if self.isInTheChat(id: message?.sender_id) {
                ChatMediator.shared.messages.delete(id: message?.id)
            } else if self.inTheChatList() {
                ChatListMediator.shared.getChatList()
            }
        })
    }

    private func parceMessageData(event: PusherEvent) -> Message? {
        if event.data != nil {
            let jsonData = event.data?.replacingOccurrences(of: "\\", with: "") ?? ""
            let messageObject = try? JSONDecoder().decode(SocketMessage .self, from: jsonData.data(using: .utf8)!)

            return messageObject?.message
        }
        return nil
    }

    func isInTheChat(id: Int?) -> Bool {
        self.store?.state.activeScreen == .CHAT && id == ChatMediator.shared.user.id
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
