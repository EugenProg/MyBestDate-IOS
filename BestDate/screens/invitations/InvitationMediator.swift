//
//  InvitationMediator.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import Foundation

class InvitationMediator: ObservableObject {
    static var shared = InvitationMediator()

    @Published var activeType: InvitationType = .new
    @Published var newInvitations: [Invitation] = []
    @Published var answerdInvitations: [Invitation] = []
    @Published var sentInvitations: [Invitation] = []

    func setInvitations(users: [ShortUserInfo]) {
        for user in users {
        let invitation = Invitation(
            id: 0,
            from_user: user,
            to_user: user,
            status: true)

        newInvitations.append(invitation)
        sentInvitations.append(invitation)
        answerdInvitations.append(invitation)
        }
    }
}

enum InvitationType: String {
    case new
    case answered
    case sended

    var title: String {
        switch self {
        case .new: return "new"
        case .answered: return "answered"
        case .sended: return "sent"
        }
    }
}
