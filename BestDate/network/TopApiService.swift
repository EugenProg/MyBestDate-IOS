//
//  TopApiService.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import Foundation

class TopApiService : NetworkRequest {
    static var shared = TopApiService()

    func getTopList(gender: GenderType, page: Int, completion: @escaping (Bool, [Top], Meta?) -> Void) {
        var request = CoreApiTypes.getTopList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let body = TopRequest(gender: gender.typeName)
        makeRequest(request: request, body: body, type: TopListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta)
        }
    }

    func getVotePhotos(gender: GenderType, completion: @escaping (Bool, [Top]) -> Void) {
        var request = CoreApiTypes.getVotingPhotos.getRequest(withAuth: true)

        let body = TopRequest(gender: gender.typeName)
        makeRequest(request: request, body: body, type: TopListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [])
        }
    }

    func voteAction(winnerId: Int, luserId: Int, completion: @escaping (Bool, [Top]) -> Void) {
        var request = CoreApiTypes.voteAction.getRequest(withAuth: true)

        let body = VotePhotos(winning_photo: winnerId, loser_photo: luserId)
        makeRequest(request: request, body: body, type: TopListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [])
        }
    }

    func getMyDuelsList(page: Int, completion: @escaping (Bool, [MyDuel], Meta) -> Void) {
        let request = CoreApiTypes.getMyVoits.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        makeRequest(request: request, type: MyDuelsListResponse.self) { response in
            completion(response?.success == true, response?.data ?? [], response?.meta ?? Meta())
        }
    }
}
