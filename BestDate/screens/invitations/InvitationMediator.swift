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
            getNewInVitations()
            getAnsweredInvitations()
            getSentInvitations()
        }
    }

    func getNewInVitations() {
        loadingMode = true
//        InvitationApiService.shared.getUserInvitationList(filter: .new) { success, invitations in
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.newInvitations.clearAndAddAll(list: invitations)
//                }
        self.loadingMode = false
//            }
//        }
    }

    func getAnsweredInvitations() {
        loadingMode = true
//        InvitationApiService.shared.getUserInvitationList(filter: .answered) { success, invitations in
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.answerdInvitations.clearAndAddAll(list: invitations)
//                }
        self.loadingMode = false
//            }
//        }
    }

    func getSentInvitations() {
        loadingMode = true
//        InvitationApiService.shared.getUserInvitationList(filter: .sent) { success, invitations in
//            DispatchQueue.main.async {
//                withAnimation {
//                    self.sentInvitations.clearAndAddAll(list: invitations)
//                }
        self.loadingMode = false
//            }
//        }
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
