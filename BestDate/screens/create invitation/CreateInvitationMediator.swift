//
//  CreateInvitationMediator.swift
//  BestDate
//
//  Created by Евгений on 25.08.2022.
//

import Foundation

class CreateInvitationMediator: ObservableObject {
    static var shared = CreateInvitationMediator()

    @Published var invitations: [Invitation] = []
    var userId: Int? = nil

    func setUser(user: ShortUserInfo) {
        self.userId = user.id
    }

    func getInvitations() {
        if self.invitations.isEmpty {
            self.getInvitationList()
        }
    }

    private func getInvitationList() {
        InvitationApiService.shared.getInvitationList { success, invitationList in
            DispatchQueue.main.async {
                self.invitations.clearAndAddAll(list: invitationList)
            }
        }
    }

    func sendInvitation(invitaionId: Int?, completion: @escaping () -> Void) {
        InvitationApiService.shared.sendInvitation(invitationId: invitaionId ?? -1, userId: userId ?? 0) { success in
            completion()
        }
    }
}

enum InvitationFilter: String {
    case new
    case answered
    case sent
}
