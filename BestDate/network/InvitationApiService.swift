//
//  InvitationApiService.swift
//  BestDate
//
//  Created by Евгений on 25.08.2022.
//

import Foundation

class InvitationApiService : NetworkRequest {
    static var shared = InvitationApiService()

    func getInvitationList(completion: @escaping (Bool, [Invitation]) -> Void) {
        let request = CoreApiTypes.getInvitationsList.getRequest(withAuth: true)

        makeRequest(request: request, type: InvitationListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [])
        }
    }

    func sendInvitation(invitationId: Int, userId: Int, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.sendInvitation.getRequest(withAuth: true)

        let body = SendInvitationRequest(invitation_id: invitationId, user_id: userId)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func answerTheInvitation(invitationId: Int, answer: InvitationAnswer, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.answerTheInvitation.getRequest(path: invitationId.toString(), withAuth: true)

        let body = AnswerTheInvitationRequest(answer_id: answer.id)
        makeRequest(request: request, body: body, type: BaseResponse.self) { response in
            completion(response?.success == true)
        }
    }

    func getUserInvitationList(filter: InvitationFilter, page: Int, completion: @escaping (Bool, [InvitationCard], Meta) -> Void) {
        var request = CoreApiTypes.getUserInvitationList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let body = GetUserInvitationFilter(filter: filter.rawValue)
        makeRequest(request: request, body: body, type: UserInvitationListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }
}
