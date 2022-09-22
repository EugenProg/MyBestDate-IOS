//
//  InvitationMediator.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import Foundation
import SwiftUI

class InvitationMediator: ObservableObject {
    static var shared = InvitationMediator()

    @Published var activeType: InvitationType = .new
    @Published var newInvitations: [InvitationCard] = []
    @Published var answerdInvitations: [InvitationCard] = []
    @Published var sentInvitations: [InvitationCard] = []
    @Published var loadingMode: Bool = true

    func getAllInvitations() {
        if newInvitations.isEmpty &&
            answerdInvitations.isEmpty &&
            sentInvitations.isEmpty {
            getNewInvitations()
            getAnsweredInvitations()
            getSentInvitations()
        }
    }

    func getNewInvitations() {
        loadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .new) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.newInvitations.clearAndAddAll(list: invitations)
                }
                self.loadingMode = false
            }
        }
    }

    func getAnsweredInvitations() {
        loadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .answered) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.answerdInvitations.clearAndAddAll(list: invitations)
                }
        self.loadingMode = false
            }
        }
    }

    func getSentInvitations() {
        loadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .sent) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.sentInvitations.clearAndAddAll(list: invitations)
                }
        self.loadingMode = false
            }
        }
    }

    func answerTheInvitation(invitationId: Int, answer: InvitationAnswer, completion: @escaping () -> Void) {
        loadingMode = true
        InvitationApiService.shared.answerTheInvitation(invitationId: invitationId, answer: answer) { _ in
            DispatchQueue.main.async {
                self.getNewInvitations()
                self.getAnsweredInvitations()
                self.loadingMode = false
                completion()
            }
        }
    }

    func getStatus(id: Int?) -> Bool? {
        switch (id ?? 0) % 3 {
        case 0: return true
        case 1: return false
        default: return nil
        }
    }

    func clearData() {
        newInvitations.removeAll()
        answerdInvitations.removeAll()
        sentInvitations.removeAll()
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

enum InvitationAnswer: String {
    case yes
    case yes_next_time
    case no
    case not_yet
    case none

    var id: Int {
        switch self {
        case .yes: return 1
        case .yes_next_time: return 2
        case .no: return 4
        case .not_yet: return 3
        case .none: return 0
        }
    }

    var text: String {
        switch self {
        case .yes: return NSLocalizedString("yes_i_agree", comment: "yes")
        case .yes_next_time: return NSLocalizedString("yes_i_will_but_next_time", comment: "yes")
        case .no: return NSLocalizedString("no", comment: "no")
        case .not_yet: return NSLocalizedString("thanks_but_i_cant_yet", comment: "no")
        case .none: return ""
        }
    }

    static func getAnswer(id: Int) -> InvitationAnswer {
        switch id {
        case 1: return .yes
        case 2: return .yes_next_time
        case 3: return .not_yet
        case 4: return .no
        default: return .none
        }
    }
}
