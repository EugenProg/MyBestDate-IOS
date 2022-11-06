//
//  InvitatinsScreen.swift
//  BestDate
//
//  Created by Евгений on 21.08.2022.
//

import SwiftUI

struct InvitatinsScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = InvitationMediator.shared

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "inviations", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 0, trailing: 18))

            InvitationsPagerToggleView(activePage: $mediator.activeType)

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            SaveRefreshAndSetPositionScrollView(onRefresh: { done in
                mediator.refreshList() { done() }
            }) {
                InvitationsListView(
                    newList: $mediator.newInvitations,
                    answerdList: $mediator.answerdInvitations,
                    sentList: $mediator.sentInvitations,
                    page: $mediator.activeType,
                    loadingMode: $mediator.loadingMode,
                    answerAction: answer(),
                    showUserAction: showUser())
                .padding(.init(top: 14, leading: 0, bottom: 16, trailing: 0))
            }.padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                mediator.getAllInvitations()
            }
    }

    private func answer() -> (Int, InvitationAnswer) -> Void {
        { id, answer in
            store.dispatch(action: .startProcess)
            mediator.answerTheInvitation(invitationId: id, answer: answer) {
                DispatchQueue.main.async {
                    store.dispatch(action: .endProcess)
                }
            }
        }
    }

    private func showUser() -> (ShortUserInfo?) -> Void {
        { user in
            AnotherProfileMediator.shared.setUser(user: user ?? ShortUserInfo())
            store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
        }
    }
}

struct InvitatinsScreen_Previews: PreviewProvider {
    static var previews: some View {
        InvitatinsScreen()
    }
}
