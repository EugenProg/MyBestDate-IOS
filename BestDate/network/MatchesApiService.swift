//
//  MatchesApiService.swift
//  BestDate
//
//  Created by Евгений on 11.08.2022.
//

import Foundation

class MatchesApiService {
    static var shared = MatchesApiService()
    private let encoder = JSONEncoder()

    func getMatchesList(completion: @escaping (Bool, [ShortUserInfo]) -> Void) {
        let request = CoreApiTypes.getMatchUsers.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(UserListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func getUserMatches(completion: @escaping (Bool, [Match]) -> Void) {
        let request = CoreApiTypes.getMatchList.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(MatchesListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func getUserLikes(completion: @escaping (Bool, [Like]) -> Void) {
        let request = CoreApiTypes.getUserLikes.getRequest(withAuth: true)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(LikesListResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data)
            } else {
                completion(false, [])
            }
        }

        task.resume()
    }

    func matchAction(userId: Int, completion: @escaping (Bool, Match) -> Void) {
        var request = CoreApiTypes.matchAction.getRequest(withAuth: true)

        let data = try! encoder.encode(MatchActionRequest(user_id: userId))
        encoder.outputFormatting = .prettyPrinted
        request.httpBody = data

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.printLog(response: response)
            if let data = data, let response = try? JSONDecoder().decode(MatchResponse.self, from: data) {
                NetworkLogger.printLog(data: data)
                completion(response.success, response.data ?? Match())
            } else {
                completion(false, Match())
            }
        }

        task.resume()
    }
}
