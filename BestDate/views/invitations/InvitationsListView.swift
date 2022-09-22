//
//  InvitationsListView.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct InvitationsListView: View {
    @Binding var newList: [InvitationCard]
    @Binding var answerdList: [InvitationCard]
    @Binding var sentList: [InvitationCard]
    @Binding var page: InvitationType
    @Binding var loadingMode: Bool

    var answerAction: (Int, InvitationAnswer) -> Void
    var showUserAction: (ShortUserInfo?) -> Void

    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    fileprivate func listView(list: [InvitationCard], type: InvitationType) -> some View {
        LazyVGrid(columns: items, alignment: .center, spacing: 16,
                  pinnedViews: [.sectionHeaders, .sectionFooters]) {
            ForEach(list.indices, id: \.self) { index in
                Group {
                    switch type {
                    case .new: NewInvitationItemView(invitationCard: list[index], answerAction: answerAction, userSelectAction: showUserAction)
                    case .answered: AnsweredInvitationItemView(invitationCard: list[index], userSelectAction: showUserAction)
                    case .sended: SendedInvitationItemView(invitationCard: list[index], userSelectAction: showUserAction)
                    }
                }
            }
        }
    }

    var body: some View {
        if loadingMode {
            ProgressView()
                .tint(ColorList.white.color)
                .frame(width: 80, height: 80)
                .padding(100)
        } else if newList.isEmpty && page == .new {
            NoDataBoxView(text: "you_have_no_new_invitations")
                .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
        } else if answerdList.isEmpty && page == .answered {
            NoDataBoxView(text: "you_have_no_answered_invitations")
                .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
        } else if sentList.isEmpty && page == .sended {
            NoDataBoxView(text: "you_have_no_invitations_sent")
                .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
        } else {
            if page == .new {
                listView(list: newList, type: .new)
            } else if page == .answered {
                listView(list: answerdList, type: .answered)
            } else {
                listView(list: sentList, type: .sended)
            }
        }
    }
}
