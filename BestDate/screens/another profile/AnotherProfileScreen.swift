//
//  OtherProfileScreen.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct AnotherProfileScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AnotherProfileMediator.shared

    var body: some View {
        ZStack {
            if mediator.user.blocked_me == true {
                BlockedUserView()
            } else {
                ActiveUserView()

                AnotherProfileNavigationPanelView(isLiked: $mediator.mainLiked) {
                    if store.state.screenStack.last == .CHAT {
                        store.dispatch(action: .navigationBack)
                    } else {
                        ChatMediator.shared.setUser(user: mediator.user)
                        store.dispatch(action: .navigate(screen: .CHAT))
                    }
                } likeClick: {
                    mediator.likePhoto(id: mediator.mainPhoto.id) { }
                } createClick: {
                    if UserDataHolder.shared.invitationSendAllowed() {
                        CreateInvitationMediator.shared.setUser(user: mediator.user.toShortUser())
                        store.dispatch(action: .createInvitation)
                    } else {
                        store.dispatch(action: .showInvitationBunningDialog)
                    }
                }.zIndex(15)
            }
        }.frame(width: UIScreen.main.bounds.width)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $mediator.showShareSheet) {
                ActivityViewController(activityItems:
                                        [DeeplinkCreator().get(userId: mediator.user.id, userName: mediator.user.name ?? "")]
                )
            }
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
                mediator.clear = false
            }
            .onDisappear {
                if mediator.clear { mediator.cleanUserData() }
            }
    }
}

