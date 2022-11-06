//
//  ChatOnlyCardBottomView.swift
//  BestDate
//
//  Created by Евгений on 23.08.2022.
//

import SwiftUI

struct ChatOnlyCardBottomView: View {
    var user: ShortUserInfo

    var body: some View {
        VStack {
            Spacer()

            ZStack {
                Rectangle()
                    .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                    .background(MyColor.getColor(39, 47, 51))
                    .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                    .shadow(color: MyColor.getColor(17, 28, 34, 0.45), radius: 46, y: -7)

                VStack {
                    Image("ic_only_cards")
                        .padding(.init(top: 34, leading: 18, bottom: 0, trailing: 0))
                }.frame(width: UIScreen.main.bounds.width, height: 161, alignment: .topLeading)

                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        AsyncImageView(url: user.main_photo?.thumb_url)
                            .clipShape(Circle())
                            .frame(width: 29, height: 29)

                        Text("chat_closed".localized().uppercased())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 16))
                    }

                    Text("this_user_craves_only_real_meetengs".localized())
                        .foregroundColor(ColorList.white_70.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                        .multilineTextAlignment(.center)
                        .padding(.init(top: 0, leading: 76, bottom: 10, trailing: 65))
                }

            }.frame(width: UIScreen.main.bounds.width, height: 161)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

