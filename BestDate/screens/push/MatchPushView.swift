//
//  MatchPushView.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct MatchPushView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PushMediator.shared

    var closeAction: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(MyColor.getColor(36, 145, 255))
                            .blur(radius: 30)

                        Image("ic_notify_match")
                    }.frame(width: 47, height: 44)

                    Text("\(NSLocalizedString("matches", comment: "Matches"))!")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))

                    Spacer()

                    Button(action: {
                        closeAction()
                    }) {
                        Image("ic_close_white")
                            .resizable()
                            .frame(width: 13, height: 13)
                            .padding(5)
                    }.padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
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
}
