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

    @Published var newsMeta: Meta = Meta()
    @Published var answeredMeta: Meta = Meta()
    @Published var sentMeta: Meta = Meta()

    func getAllInvitations() {
        if newInvitations.isEmpty &&
            answerdInvitations.isEmpty &&
            sentInvitations.isEmpty {
            getNewInvitations(withClear: true, page: 0) { }
            getAnsweredInvitations(withClear: true, page: 0) { }
            getSentInvitations(withClear: true, page: 0) { }
        }
    }

    func refreshList(completion: @escaping () -> Void) {
        switch activeType {
        case .new: getNewInvitations(withClear: true, page: 0) { completion() }
        case .answered: getAnsweredInvitations(withClear: true, page: 0) { completion() }
        case .sended: getSentInvitations(withClear: true, page: 0) { completion() }
        }
    }

    func getNewInvitations(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        newLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .new, page: page) { success, invitations, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.newInvitations.addAll(list: invitations, clear: withClear)
                    self.newsMeta = meta
                }
                completion()
                self.newLoadingMode = false
            }
        }
    }

    func getAnsweredInvitations(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        answerdLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .answered, page: page) { success, invitations, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.answerdInvitations.addAll(list: invitations, clear: withClear)
                    self.answeredMeta = meta
                }
                completion()
                self.answerdLoadingMode = false
            }
        }
    }

    func getSentInvitations(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        sentLoadingMode = true
        InvitationApiService.shared.getUserInvitationList(filter: .sent, page: page) { success, invitations, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.sentInvitations.addAll(list: invitations, clear: withClear)
                    self.sentMeta = meta
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
                self.getAnsweredInvitations(withClear: true, page: 0) { }
                self.loadingMode = false
                completion()
            }
        }
    }

    func getNextPage(type: InvitationType) {
        switch type {
        case .new: do {
            if (newsMeta.current_page ?? 0) >= (newsMeta.last_page ?? 0) { return }

            getNewInvitations(withClear: false, page: (newsMeta.current_page ?? 0) + 1) { }
        }
        case .answered: do {
            if (answeredMeta.current_page ?? 0) >= (answeredMeta.last_page ?? 0) { return }

            getAnsweredInvitations(withClear: false, page: (answeredMeta.current_page ?? 0) + 1) { }
        }
        case .sended: do {
            if (sentMeta.current_page ?? 0) >= (sentMeta.last_page ?? 0) { return }

            getSentInvitations(withClear: false, page: (sentMeta.current_page ?? 0) + 1) { }
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
