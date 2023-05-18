//
//  InvitationPushView.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct InvitationPushView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PushMediator.shared

    var closeAction: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(ColorList.pink.color)
                            .blur(radius: 30)

                        Image("ic_add")
                    }.frame(width: 47, height: 44)

                    Text("invitation_card".localized())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))

                    Spacer()
                }

                PushUserDataView(user: $mediator.user)
            }.padding(21)
                .frame(width: UIScreen.main.bounds.width - 36)
        }.background(
            RoundedRectangle(cornerRadius: 32)
                .stroke(MyColor.getColor(255, 255, 255, 0.16), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(32)
                .shadow(color: MyColor.getColor(17, 24, 28, 0.17), radius: 46, y: 14)
        )
        .onTapGesture {
            closeAction()
            openInvitationCard()
        }
    }

    private func openInvitationCard() {
        let activePush: InvitationType = store.state.activePush == .invitation ? .new : .sended
        InvitationMediator.shared.activeType = activePush
        if activePush == .new { InvitationMediator.shared.getNewInvitations(withClear: true, page: 0) { } }
        else { InvitationMediator.shared.getAnsweredInvitations(withClear: true, page: 0) { } }
        store.dispatch(action: .navigate(screen: .INVITATION))
    }
}
