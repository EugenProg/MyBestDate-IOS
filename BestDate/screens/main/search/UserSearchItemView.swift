//
//  UserSearchItemView.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct UserSearchItemView: View {
    var user: UserInfo

    var body: some View {
        ZStack {
            Rectangle()
                .stroke(MyColor.getColor(255, 255, 255, 0.04), lineWidth: 1)
                .background(MyColor.getColor(34, 45, 51))
                .shadow(color: MyColor.getColor(12, 28, 33, 0.24), radius: 2, y: 3)
                .padding(.init(top: 0, leading: 4, bottom: 0, trailing: 4))

            AsyncImageView(url: user.getMainPhoto()?.full_url)
                .padding(.init(top: 0, leading: 0, bottom: 54, trailing: 0))

            VStack(alignment: .leading, spacing: 0) {
                Spacer()

                ZStack {
                    Rectangle()
                        .fill(LinearGradient(gradient:
                                                Gradient(colors: [
                                                    MyColor.getColor(40, 48, 52, 0.62),
                                                    MyColor.getColor(40, 48, 52, 0.17),
                                                    MyColor.getColor(40, 48, 52, 0.0)
                                                ]), startPoint: .bottom, endPoint: .top))
                    HStack(spacing: 4) {
                        Image("ic_signal")

                        Text("3.1 Miles")
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 12))

                        Spacer()
                    }.padding(.init(top: 0, leading: 10, bottom: 0, trailing: 0))
                }.frame(height: 28)
                    .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
                HStack(spacing: 2) {
                    Text(user.name ?? "Noname")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 16))

                    Image((user.questionnaire?.isFull() ?? false) ? "ic_verify_active" : "ic_verify_gray")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .padding(.init(top: 0, leading: 5, bottom: 0, trailing: 0))

                    Spacer()

                    Text("\(user.getAge())")
                        .foregroundColor(ColorList.white_80.color)
                        .font(MyFont.getFont(.BOLD, 16))

                    Text("y")
                        .foregroundColor(ColorList.white_80.color)
                        .font(MyFont.getFont(.BOLD, 10))
                }.padding(.init(top: 7, leading: 13, bottom: 2, trailing: 10))

                Text(user.questionnaire?.occupation ?? "Luser")
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 12))
                    .padding(.init(top: 1, leading: 13, bottom: 7, trailing: 10))
            }
        }.frame(height: ((UIScreen.main.bounds.width - 9) / 2) + 54)
    }
}
