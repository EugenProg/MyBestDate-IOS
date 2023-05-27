//
//  DuelMediator.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import Foundation
import SwiftUI

class DuelMediator: ObservableObject {
    static var shared = DuelMediator()

    @Published var firstUser: Top? = nil
    @Published var secondUser: Top? = nil
    @Published var firstUserImage: ProfileImage? = nil
    @Published var secondUserImage: ProfileImage? = nil

    @Published var firstDuelImage: ProfileImage? = nil
    @Published var secondDuelImage: ProfileImage? = nil

    @Published var activeGender: GenderType = .woman
    @Published var place: String = "universe".localized()

    @Published var hasADuelAction: Bool = false
    @Published var loadingMode: Bool = true

    var womanVoted: Bool = false
    var manVoted: Bool = false

    init() {
        if UserDataHolder.shared.getUser().gender == "female" {
            activeGender = .man
        } else {
            activeGender = .woman
        }
    }

    func voteAction(winning: Int, luser: Int, completion: @escaping (Bool) -> Void) {
        TopApiService.shared.voteAction(winnerId: winning, luserId: luser) { success, list in
            DispatchQueue.main.async {
                if list.count > 1 {
                    withAnimation {
                        self.firstUser = list[0]
                        self.firstUserImage = list[0].getImage()
                        self.secondUser = list[1]
                        self.secondUserImage = list[1].getImage()

                        if self.activeGender == .man {
                            self.manVoted = true
                        } else {
                            self.womanVoted = true
                        }
                    }
                }
                completion(success)
            }
        }
    }

    func getVotePhotos(completion: @escaping (Bool) -> Void) {
        loadingMode = true
        TopApiService.shared.getVotePhotos(gender: activeGender) { success, users in
            DispatchQueue.main.async {
                self.hasADuelAction = success
                if success && users.count > 1 {
                    withAnimation {
                        self.firstDuelImage = users[0].getImage()
                        self.secondDuelImage = users[1].getImage()
                    }
                }
                self.loadingMode = false
                completion(success)
            }
        }
    }

    func clearDuels() {
        self.firstDuelImage = nil
        self.secondDuelImage = nil
        self.firstUserImage = nil
        self.secondUserImage = nil
        self.firstUser = nil
        self.secondUser = nil
        self.hasADuelAction = false
    }
}
