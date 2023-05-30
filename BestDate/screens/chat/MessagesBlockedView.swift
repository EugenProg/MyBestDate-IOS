//
//  MessagesBlockedView.swift
//  BestDate
//
//  Created by Евгений on 30.05.2023.
//

import SwiftUI

struct MessagesBlockedView: View {
    var toSettings: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(MyColor.getColor(190, 239, 255, 0.08), lineWidth: 1)
                .background(LinearGradient(colors: [
                    MyColor.getColor(44, 56, 60),
                    MyColor.getColor(37, 49, 54)
                ], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(24)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16),radius: 16, y: 10)

            HStack(alignment: .top, spacing: 18) {
                VStack {
                    Image("ic_message_active")
                        .padding(.init(top: 24, leading: 24, bottom: 0, trailing: 0))

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text("chat_closed".localized().uppercased())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 16))

                    Text("your_interlocutor_sees_the_messages".localized().uppercased())
                        .foregroundColor(ColorList.light_blue.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                        .padding(.top, 6)

                    Rectangle()
                        .fill(ColorList.white_10.color)
                        .frame(width: UIScreen.main.bounds.width - 148, height: 1)
                        .padding(.top, 15)

                    Text("go_to_settings_and_unlock_the_chat")
                        .foregroundColor(ColorList.white_70.color)
                        .font(MyFont.getFont(.NORMAL, 13))
                        .padding(.top, 17)

                    Button {
                        withAnimation {
                            toSettings()
                        }
                    } label: {
                        ToSettingsButton(backColor: MyColor.getColor(64, 76, 82),
                                         shadowColor: MyColor.getColor(18, 25, 29, 0.16))
                    }.padding(.top, 9)
                }.padding(.top, 24)
                    .padding(.bottom, 17)

                Spacer(minLength: 0)
            }
        }.frame(maxWidth: UIScreen.main.bounds.width - 32, minHeight: 198)
            .padding(.bottom, 16)
    }
}
