//
//  TopApiService.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import Foundation

class TopApiService {
    static var shared = TopApiService()
    private let encoder = JSONEncoder()

    func getTopList(gender: GenderType, page: Int, completion: @escaping (Bool, [Top], Meta?) -> Void) {
        var request = CoreApiTypes.getTopList.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let data = try! encoder.encode(TopRequest(gender: gender.typeName))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(TopListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data, response.meta)
            } else {
                completion(false, [], nil)
            }
        }

        task.resume()
    }

    func getVotePhotos(gender: GenderType, completion: @escaping (Bool, [Top]) -> Void) {
        var request = CoreApiTypes.getVotingPhotos.getRequest(withAuth: true)

        let data = try! encoder.encode(TopRequest(gender: gender.typeName))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(TopListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func voteAction(winnerId: Int, luserId: Int, completion: @escaping (Bool, [Top]) -> Void) {
        var request = CoreApiTypes.voteAction.getRequest(withAuth: true)

        let data = try! encoder.encode(VotePhotos(winning_photo: winnerId, loser_photo: luserId))
        encoder.outputFormatting = .prettyPrinted
        NetworkLogger.printLog(data: data)
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(TopListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func getMyDuelsList(page: Int, completion: @escaping (Bool, [MyDuel], Meta) -> Void) {
        let request = CoreApiTypes.getMyVoits.getRequest(withAuth: true, params: CoreApiTypes.getPageParams(page: page))

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(MyDuelsListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data, response.meta ?? Meta())
            } else {
                completion(false, [], Meta())
            }
        }

        task.resume()
    }
}
