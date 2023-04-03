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
    @Published var newLoadingMode: Bool = true
    @Published var answerdLoadingMode: Bool = true
    @Published var sentLoadingMode: Bool = true
    @Published var loadingMode: Bool = true

    func getAllInvitations() {
        if newInvitations.isEmpty &&
            answerdInvitations.isEmpty &&
            sentInvitations.isEmpty {
            getNewInvitations { }
            getAnsweredInvitations { }
            getSentInvitations { }
        }
    }

    func refreshList(completion: @escaping () -> Void) {
        switch activeType {
        case .new: getNewInvitations { completion() }
        case .answered: getAnsweredInvitations { completion() }
        case .sended: getSentInvitations { completion() }
        }
    }

    func getNewInvitations(completion: @escaping () -> Void) {
        newLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .new) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.newInvitations.clearAndAddAll(list: invitations)
                }
                completion()
                self.newLoadingMode = false
            }
        }
    }

    func getAnsweredInvitations(completion: @escaping () -> Void) {
        answerdLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .answered) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.answerdInvitations.clearAndAddAll(list: invitations)
                }
                completion()
                self.answerdLoadingMode = false
            }
        }
    }

    func getSentInvitations(completion: @escaping () -> Void) {
        sentLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .sent) { success, invitations in
            DispatchQueue.main.async {
                withAnimation {
                    self.sentInvitations.clearAndAddAll(list: invitations)
                }
                completion()
                self.sentLoadingMode = false
            }
        }
    }

    func answerTheInvitation(invitationId: Int, answer: InvitationAnswer, completion: @escaping () -> Void) {
        loadingMode = true
        InvitationApiService.shared.answerTheInvitation(invitationId: invitationId, answer: answer) { _ in
            DispatchQueue.main.async {
                self.newInvitations.removeAll { card in
                    card.id == invitationId
                }
                self.getAnsweredInvitations { }
                self.loadingMode = false
                completion()
            }
        }
    }

    func clearData() {
        activeType = .new
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
        case .new: return "new".localized()
        case .answered: return "answered".localized()
        case .sended: return "sent".localized()
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
        case .yes: return "yes_i_agree".localized()
        case .yes_next_time: return "yes_i_will_but_next_time".localized()
        case .no: return "no".localized()
        case .not_yet: return "thanks_but_i_cant_yet".localized()
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
