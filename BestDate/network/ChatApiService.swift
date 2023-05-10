//
//  ChatApiService.swift
//  BestDate
//
//  Created by Евгений on 15.07.2022.
//

import Foundation

class ChatApiService : NetworkRequest {
    static var shared = ChatApiService()

    func getChatList(page: Int, completion: @escaping (Bool, [Chat], Meta) -> Void) {
        let request = CoreApiTypes.getChatList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: ChatListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func deleteChat(id: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.deleteChat.getRequest(path: id.toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func deleteMessage(id: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.deleteMessage.getRequest(path: id.toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func updateMessage(id: Int, message: String, completion: @escaping (Bool, Message) -> Void) {
        let request = CoreApiTypes.updateMessage.getRequest(path: id.toString(), withAuth: true)

        let body = SendMessageRequest(text: message)
        makeRequest(request: request, body: body, type: SendMessageResponse.self) { response in
            completion(response?.success == true, response?.data ?? Message())
        }
    }

    func sendTextMessage(userId: Int, parentId: Int?, message: String, completion: @escaping (Bool, Message) -> Void) {
        let path = parentId == nil ? userId.toString() : "\(userId)/\(parentId!)"
        let request = CoreApiTypes.sendMessage.getRequest(path: path, withAuth: true)

        let body = SendMessageRequest(text: message)
        makeRequest(request: request, body: body, type: SendMessageResponse.self) { response in
            UserDataHolder.shared.setSentMessagesCount(count: response?.data?.sent_messages_today ?? 0)
            completion(response?.success == true, response?.data ?? Message())
        }
    }

    func getChatMessages(userId: Int, page: Int, completion: @escaping (Bool, [Message], Meta) -> Void) {
        let request = CoreApiTypes.getChatMessages.getRequest(path: userId.toString(), withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: GetChatMessagesResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func sendTypingEvent(recepient: Int, completion: @escaping () -> Void) {
        let request = CoreApiTypes.chatTypingEvent.getRequest(path: recepient.toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { _ in }
    }

    func sendReadEvent(recepient: Int) {
        let request = CoreApiTypes.chatReadEvent.getRequest(path: recepient.toString(), withAuth: true)

        makeRequest(request: request, type: BaseResponse.self) { _ in }
    }
}
