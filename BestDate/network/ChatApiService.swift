//
//  ChatApiService.swift
//  BestDate
//
//  Created by Евгений on 15.07.2022.
//

import Foundation

class ChatApiService {
    static var shared = ChatApiService()
    private let encoder = JSONEncoder()

    func getChatList(page: Int, completion: @escaping (Bool, [Chat], Meta) -> Void) {
        let request = CoreApiTypes.getChatList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(ChatListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data, response.meta ?? Meta())
            } else {
                completion(false, [], Meta())
            }
        }

        task.resume()
    }

    func deleteChat(id: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.deleteChat.getRequest(path: id.toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func deleteMessage(id: Int, completion: @escaping (Bool) -> Void) {
        let request = CoreApiTypes.deleteMessage.getRequest(path: id.toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success)
            } else {
                completion(false)
            }
        }

        task.resume()
    }

    func updateMessage(id: Int, message: String, completion: @escaping (Bool, Message) -> Void) {
        var request = CoreApiTypes.updateMessage.getRequest(path: id.toString(), withAuth: true)

        let data = try! encoder.encode(SendMessageRequest(text: message))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(SendMessageResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? Message())
            } else {
                completion(false, Message())
            }
        }

        task.resume()
    }

    func sendTextMessage(userId: Int, parentId: Int?, message: String, completion: @escaping (Bool, Message) -> Void) {
        let path = parentId == nil ? userId.toString() : "\(userId)/\(parentId!)"
        var request = CoreApiTypes.sendMessage.getRequest(path: path, withAuth: true)

        let data = try! encoder.encode(SendMessageRequest(text: message))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(SendMessageResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? Message())
            } else {
                completion(false, Message())
            }
        }

        task.resume()
    }

    func getChatMessages(userId: Int, page: Int, completion: @escaping (Bool, [Message], Meta) -> Void) {
        let request = CoreApiTypes.getChatMessages.getRequest(path: userId.toString(), withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(GetChatMessagesResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data, response.meta ?? Meta())
            } else {
                completion(false, [], Meta())
            }
        }

        task.resume()
    }

    func sendTypingEvent(recepient: Int, completion: @escaping () -> Void) {
        let request = CoreApiTypes.chatTypingEvent.getRequest(path: recepient.toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let _ = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
            }
            completion()
        }

        task.resume()
    }

    func sendReadEvent(recepient: Int) {
        let request = CoreApiTypes.chatReadEvent.getRequest(path: recepient.toString(), withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let _ = try? JSONDecoder().decode(BaseResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
            }
        }

        task.resume()
    }
}
