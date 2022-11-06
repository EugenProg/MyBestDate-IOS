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

                    Button(action: {
                        closeAction()
                        openInvitationCard()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 11)
                                .fill(ColorList.light_blue.color)
                                .frame(width: 75, height: 22)

                            Text("go_to")
                                .foregroundColor(ColorList.main.color)
                                .font(MyFont.getFont(.BOLD, 14))
                        }
                    }
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
            withAnimation {
                AnotherProfileMediator.shared.setUser(user: mediator.user ?? ShortUserInfo())
                store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
            }
        }
    }

    private func openInvitationCard() {
        store.dispatch(action: .navigate(screen: .INVITATION))
    }
}
