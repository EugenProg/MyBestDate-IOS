//
//  MatchesApiService.swift
//  BestDate
//
//  Created by Евгений on 11.08.2022.
//

import Foundation

class MatchesApiService : NetworkRequest {
    static var shared = MatchesApiService()

    func getMatchesList(completion: @escaping (Bool, [ShortUserInfo]) -> Void) {
        let request = CoreApiTypes.getMatchUsers.getRequest(withAuth: true)

        makeRequest(request: request, type: UserListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [])
        }
    }

    func getUserMatches(page: Int, completion: @escaping (Bool, [Match], Meta) -> Void) {
        let request = CoreApiTypes.getMatchList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: MatchesListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func getUserLikes(page: Int, completion: @escaping (Bool, [Like], Meta) -> Void) {
        let request = CoreApiTypes.getUserLikes.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: LikesListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }

    func matchAction(userId: Int, completion: @escaping (Bool, Match) -> Void) {
        let request = CoreApiTypes.matchAction.getRequest(withAuth: true)

        let body = MatchActionRequest(user_id: userId)
        makeRequest(request: request, body: body, type: MatchResponse.self) { response in
            completion(response?.success == true, response?.data ?? Match())
        }
    }
}
