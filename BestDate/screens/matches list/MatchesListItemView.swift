//
//  MatchesListItemView.swift
//  BestDate
//
//  Created by Евгений on 27.08.2022.
//

import SwiftUI

struct MatchesListItemView: View {
    @Binding var match: Match
    @Binding var myPhoto: ProfileImage?

    var userSelectAction: (ShortUserInfo) -> Void
    var showMatchAction: (Match) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .stroke(MyColor.getColor(255, 255, 255, 0.05), lineWidth: 1.5)
                .background(MyColor.getColor(45, 54, 59))
                .cornerRadius(18)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.1), radius: 16, y: 8)
                .frame(width: UIScreen.main.bounds.width - 36, height: 96)
                .padding(.init(top: 3, leading: 18, bottom: 0, trailing: 18))

            Image("ic_matches")
                .resizable()
                .frame(width: 38, height: 38)
                .padding(.init(top: 0, leading: 13, bottom: 62, trailing: UIScreen.main.bounds.width - 51))

            ZStack {
                Image("bg_match_avatar")

                UserImageView(user: $match.user)
                    .clipShape(Circle())
                    .frame(width: 41, height: 41)
            }.padding(.init(top: 15, leading: 33, bottom: 11, trailing: UIScreen.main.bounds.width - 106))

            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 8) {
                    Text(match.user?.name ?? "")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 16))

                    Image((match.user?.full_questionnaire ?? false) ? "ic_verify_active" : "ic_verify_gray")
                        .resizable()
                        .frame(width: 12, height: 12)
                }

                Text(match.user?.getLocation() ?? "")
                    .foregroundColor(ColorList.white_70.color)
                    .font(MyFont.getFont(.NORMAL, 12))

                Text(match.getTime())
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 13))
                    .padding(.init(top: 8, leading: 0, bottom: 0, trailing: 0))

            }
            .frame(width: UIScreen.main.bounds.width - 230, alignment: .leading)
                .padding(.init(top: 20, leading: 100, bottom: 0, trailing: 130))

            ZStack {
                UpdateImageView(image: $myPhoto)
                    .cornerRadius(radius: 8, corners: [.topLeft, .bottomLeft, .bottomRight])
                    .cornerRadius(radius: 13, corners: [.topRight])
                    .frame(width: 41, height: 41)
                    .padding(.init(top: 1, leading: 32, bottom: 34, trailing: 1))

                UserImageView(user: $match.user)
                    .cornerRadius(radius: 8, corners: [.topLeft, .topRight, .bottomRight])
                    .cornerRadius(radius: 13, corners: [.bottomLeft])
                    .frame(width: 41, height: 41)
                    .padding(.init(top: 34, leading: 1, bottom: 1, trailing: 32))
            }.frame(width: 74, height: 76)
                .background(ColorList.white_5.color)
                .cornerRadius(14)
                .padding(.init(top: 3, leading: UIScreen.main.bounds.width - 102, bottom: 0, trailing: 28))

            ZStack {
                Circle()
                    .fill(ColorList.pink.color)
                    .blur(radius: 20)
                    .frame(width: 24, height: 24)

                Text("Match!")
                    .foregroundColor(ColorList.pink.color)
                    .font(MyFont.getFont(.BOLD, 13))
                    .rotationEffect(Angle(degrees: -45))
            }.padding(.init(top: 18, leading: UIScreen.main.bounds.width - 133, bottom: 36, trailing: 89))

            HStack(spacing: 0) {
                Rectangle()
                    .opacity(0.001)
                    .frame(width: UIScreen.main.bounds.width - 135, height: 99)
                    .onTapGesture {
                        withAnimation { userSelectAction(match.user ?? ShortUserInfo()) }
                    }

                Rectangle()
                    .opacity(0.001)
                    .frame(width: 135, height: 99)
                    .onTapGesture {
                        withAnimation { showMatchAction(match) }
                    }
            }
        }.frame(height: 99)
    }
}

