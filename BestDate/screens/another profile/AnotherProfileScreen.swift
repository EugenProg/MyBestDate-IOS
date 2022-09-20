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
                    ChatMediator.shared.setUser(user: mediator.user)
                    store.dispatch(action: .navigate(screen: .CHAT))
                } likeClick: {
                    mediator.likePhoto(id: mediator.mainPhoto.id) { }
                } createClick: {
                    CreateInvitationMediator.shared.setUser(user: mediator.user.toShortUser())
                    store.dispatch(action: .createInvitation)
                }.zIndex(15)
            }
        }.frame(width: UIScreen.main.bounds.width)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $mediator.showShareSheet) {
                let userId = mediator.user.id ?? 0
                ActivityViewController(activityItems: ["best-date://user/\(userId.toString())"])
            }
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }
}
