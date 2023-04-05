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
    @Binding var newMeta: Meta
    @Binding var answeredMeta: Meta
    @Binding var sentMeta: Meta

    var answerAction: (Int, InvitationAnswer) -> Void
    var showUserAction: (ShortUserInfo?) -> Void
    var loadNextPage: (InvitationType) -> Void

    @State var showLoadingBlock: Bool = false

    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    fileprivate func listView(list: [InvitationCard], type: InvitationType) -> some View {
        LazyVGrid(columns: items, alignment: .center, spacing: 16,
                  pinnedViews: [.sectionHeaders, .sectionFooters]) {
            ForEach(list.indices, id: \.self) { index in
                Group {
                    switch type {
                    case .new: NewInvitationItemView(invitationCard: list[index], answerAction: answerAction, userSelectAction: showUserAction)
                            .onAppear {
                                if (list[index].id ?? 0) == (list.last?.id ?? 0) && !list.isEmpty {
                                    showLoadingBlock = true
                                    loadNextPage(.new)
                                }
                            }
                    case .answered: AnsweredInvitationItemView(invitationCard: list[index], userSelectAction: showUserAction)
                            .onAppear {
                                if (list[index].id ?? 0) == (list.last?.id ?? 0) && !list.isEmpty {
                                    showLoadingBlock = true
                                    loadNextPage(.answered)
                                }
                            }
                    case .sended: SendedInvitationItemView(invitationCard: list[index], userSelectAction: showUserAction)
                            .onAppear {
                                if (list[index].id ?? 0) == (list.last?.id ?? 0) && !list.isEmpty {
                                    showLoadingBlock = true
                                    loadNextPage(.sended)
                                }
                            }
                    }
                }
            }
        }
    }

    var body: some View {
        VStack(spacing: 5) {
            if page == .new {
                listView(list: newList, type: .new).transition(.opacity)

                if (newMeta.current_page ?? 0) < (newMeta.last_page ?? 0) && showLoadingBlock {
                    LoadingNextPageView()
                }
            } else if page == .answered {
                listView(list: answerdList, type: .answered).transition(.opacity)

                if (answeredMeta.current_page ?? 0) < (answeredMeta.last_page ?? 0) && showLoadingBlock {
                    LoadingNextPageView()
                }
            } else {
                listView(list: sentList, type: .sended).transition(.opacity)

                if (sentMeta.current_page ?? 0) < (sentMeta.last_page ?? 0) && showLoadingBlock {
                    LoadingNextPageView()
                }
            }
        }
    }
}
