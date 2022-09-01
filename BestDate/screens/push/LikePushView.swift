//
//  LikePushView.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct LikePushView: View {
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

                        Image("ic_notify_like")
                    }.frame(width: 47, height: 44)

                    Text(NSLocalizedString("like", comment: "like"))
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

                HStack(spacing: 16) {
                    ZStack {
                        UserImageView(user: $mediator.user)
                            .clipShape(Circle())

                        if mediator.user?.is_online == true {
                            Circle()
                                .fill(ColorList.green.color)
                                .frame(width: 9, height: 9)
                                .padding(.init(top: 24, leading: 25, bottom: 0, trailing: 0))
                        }
                    }.frame(width: 34, height: 34)
                        .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 0))

                    VStack(alignment: .leading, spacing: 3.5) {
                        Text(mediator.user?.name ?? "")
                            .foregroundColor(ColorList.white_70.color)
                            .font(MyFont.getFont(.BOLD, 16))

                        Text(mediator.user?.getLocation() ?? "")
                            .foregroundColor(ColorList.white_40.color)
                            .font(MyFont.getFont(.NORMAL, 14))
                    }

                    Spacer()

                    Text(NSLocalizedString("watch", comment: "Watch"))
                        .foregroundColor(ColorList.white_80.color)
                        .font(MyFont.getFont(.NORMAL, 16))
                        .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
                }
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
