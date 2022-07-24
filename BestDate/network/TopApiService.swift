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

    func getTopList(gender: GenderType, completion: @escaping (Bool, [Top]) -> Void) {
        var request = CoreApiTypes.getTopList.getRequest(withAuth: true)

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

    func voteAction(winnerId: Int, luserId: Int, completion: @escaping (Bool) -> Void) {
        var request = CoreApiTypes.voteAction.getRequest(withAuth: true)

        let data = try! encoder.encode(VotePhotos(winning_photo: winnerId, loser_photo: luserId))
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

    func getMyDuelsList(completion: @escaping (Bool, [MyDuel]) -> Void) {
        let request = CoreApiTypes.getMyVoits.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(MyDuelsListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }
}
