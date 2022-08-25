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

    var answerAction: (String) -> Void
    var showUserAction: (ShortUserInfo?) -> Void

    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    fileprivate func listView(list: [InvitationCard], type: InvitationType) -> some View {
        LazyVGrid(columns: items, alignment: .center, spacing: 16,
                  pinnedViews: [.sectionHeaders, .sectionFooters]) {
            ForEach(list.indices, id: \.self) { index in
                Group {
                    switch type {
                    case .new: NewInvitationItemView(invitation: list[index], answerAction: answerAction, userSelectAction: showUserAction)
                    case .answered: AnsweredInvitationItemView(invitation: list[index], userSelectAction: showUserAction)
                    case .sended: SendedInvitationItemView(invitation: list[index], userSelectAction: showUserAction)
                    }
                }
            }
        }
    }

    var body: some View {
        if newList.isEmpty && page == .new ||
            answerdList.isEmpty && page == .answered ||
            sentList.isEmpty && page == .sended {
            let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 160
            NoDataView()
                .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
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

