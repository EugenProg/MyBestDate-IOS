//
//  DuelMediator.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import Foundation

class DuelMediator: ObservableObject {
    static var shared = DuelMediator()

    @Published var firstUser: Top = Top()
    @Published var secondUser: Top = Top()

    @Published var firstUserImage: ProfileImage? = nil
    @Published var secondUserImage: ProfileImage? = nil

    func voteAction(winning: Int, luser: Int, completion: @escaping () -> Void) {
        TopApiService.shared.voteAction(winnerId: winning, luserId: luser) { success in
            DispatchQueue.main.async {
                self.firstUser = Top()
                self.secondUser = Top()
                TopListMediator.shared.updateActiveList()
                completion()
            }
        }
    }

    func getVotePhotos(type: GenderType, completion: @escaping (Bool) -> Void) {
        TopApiService.shared.getVotePhotos(gender: type) { success, users in
            DispatchQueue.main.async {
                if success && users.count > 1 {
                    self.firstUser = users[0]
                    self.firstUserImage = users[0].getImage()
                    self.secondUser = users[1]
                    self.secondUserImage = users[1].getImage()
                } else {
                    self.firstUser = Top()
                    self.secondUser = Top()
                }
                completion(success)
            }
        }
    }
}
