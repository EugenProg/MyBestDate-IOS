//
//  InvitationApiService.swift
//  BestDate
//
//  Created by Евгений on 25.08.2022.
//

import Foundation

class InvitationApiService {
    static var shared = InvitationApiService()
    private let encoder = JSONEncoder()

    func getInvitationList(completion: @escaping (Bool, [Invitation]) -> Void) {
        let request = CoreApiTypes.getInvitationsList.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(InvitationListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func sendInvitation(invitationId: Int, userId: Int, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.sendInvitation.getRequest(withAuth: true)

        let data = try! encoder.encode(SendInvitationRequest(invitation_id: invitationId, user_id: userId))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
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

    func answerTheInvitation(invitationId: Int, answer: InvitationAnswer, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.answerTheInvitation.getRequest(path: invitationId.toString(), withAuth: true)

        let data = try! encoder.encode(AnswerTheInvitationRequest(answer_id: answer.id))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
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

    func getUserInvitationList(filter: InvitationFilter, completion: @escaping (Bool, [InvitationCard]) -> Void) {
        var request = CoreApiTypes.getUserInvitationList.getRequest(withAuth: true)

        let data = try! encoder.encode(GetUserInvitationFilter(filter: filter.rawValue))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserInvitationListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }
}
