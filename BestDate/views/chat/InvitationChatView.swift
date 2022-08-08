//
//  InvitationChatView.swift
//  BestDate
//
//  Created by Евгений on 06.08.2022.
//

import SwiftUI

struct InvitationChatView: View {
    var body: some View {
        VStack(spacing: 27) {
            HStack(spacing: 16) {
                Image("ic_card_blue")

                Image("ic_card_pink")
            }

            Text("you_can_always_send_an_invitation_in_the_form_of_a_card")
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.NORMAL, 18))
                .multilineTextAlignment(.center)

            Button(action: {

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
        }.frame(width: 240)
    }
}

struct InvitationChatView_Previews: PreviewProvider {
    static var previews: some View {
        InvitationChatView()
    }
}
