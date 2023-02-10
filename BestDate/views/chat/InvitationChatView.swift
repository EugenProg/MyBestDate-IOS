//
//  InvitationChatView.swift
//  BestDate
//
//  Created by Евгений on 06.08.2022.
//

import SwiftUI

struct InvitationChatView: View {
    @Binding var onlyCards: Bool

    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image("ic_card_pink")

            if onlyCards {
                Text("only_cards".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 28))
                    .multilineTextAlignment(.center)
                    .padding(.init(top: 19, leading: 0, bottom: 3, trailing: 0))

                Text("this_user_agrees_to_accept_only_cards".localized())
                    .foregroundColor(ColorList.white_70.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .multilineTextAlignment(.center)
                    .padding(.init(top: 3, leading: 0, bottom: 30, trailing: 0))
            } else {
                Text("you_can_always_send_an_invitation_in_the_form_of_a_card".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .multilineTextAlignment(.center)
                    .padding(.init(top: 27, leading: 0, bottom: 27, trailing: 0))
            }

            Button(action: {
                withAnimation { clickAction() }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(ColorList.light_blue.color)
                        .frame(width: 137, height: 22)

                    Text("go_to")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 14))
                }
            }
        }.frame(width: UIScreen.main.bounds.width - 64)
            .padding(.init(top: 0, leading: 0, bottom: onlyCards ? 50 : 0, trailing: 0))
    }
}
