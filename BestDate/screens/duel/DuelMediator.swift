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

    func voteAction(winning: Int, luser: Int, completion: @escaping () -> Void) {
        TopApiService.shared.voteAction(winnerId: winning, luserId: luser) { success in
            DispatchQueue.main.async {
                self.firstUser = Top()
                self.secondUser = Top()
                completion()
            }
        }
    }

    func getVotePhotos(type: GenderType) {
        TopApiService.shared.getVotePhotos(gender: type) { success, users in
            DispatchQueue.main.async {
                if success && users.count > 1 {
                    self.firstUser = users[0]
                    self.secondUser = users[1]
                } else {
                    self.firstUser = Top()
                    self.secondUser = Top()
                }
            }
        }
    }
}
