//
//  LikesListItemView.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import SwiftUI

struct LikesListItemView: View {
    @Binding var like: Like

    var body: some View {
        HStack(spacing: 13) {
            ZStack {
                UserImageView(user: $like.user)
                    .clipShape(Circle())

                Circle()
                    .fill(like.user?.is_online == true ? ColorList.green.color : ColorList.white_60.color)
                    .frame(width: 7, height: 7)
                    .padding(.init(top: 22, leading: 23, bottom: 0, trailing: 0))
            }.frame(width: 32, height: 32)
                .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 0))

            VStack(alignment: .leading, spacing: 1) {
                Text(like.user?.name ?? "")
                    .foregroundColor(ColorList.white_90.color)
                    .font(MyFont.getFont(.BOLD, 14))

                Text(NSLocalizedString("this_user_liked_your_photo", comment: "like"))
                    .foregroundColor(ColorList.white_50.color)
                    .font(MyFont.getFont(.NORMAL, 12))
            }

            Spacer()

            Text(like.getTime())
                .foregroundColor(ColorList.white_80.color)
                .font(MyFont.getFont(.NORMAL, 14))

            ZStack {
                UpdateImageView(image: $like.photo)
                    .frame(width: 46, height: 46)
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 18))

                Image("ic_like_heart")
                    .padding(.init(top: 41, leading: 35, bottom: 0, trailing: 13))
            }.frame(width: 64, height: 56)
        }
        .frame(width: UIScreen.main.bounds.width, height: 72)
        .background(MyColor.getColor(28, 38, 43))
    }
}

