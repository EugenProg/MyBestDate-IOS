//
//  PushUserDataView.swift
//  BestDate
//
//  Created by Евгений on 02.09.2022.
//

import SwiftUI

struct PushUserDataView: View {
    @Binding var user: ShortUserInfo?

    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                UserImageView(user: $user)
                    .clipShape(Circle())

                if user?.is_online == true {
                    Circle()
                        .fill(ColorList.green.color)
                        .frame(width: 9, height: 9)
                        .padding(.init(top: 24, leading: 25, bottom: 0, trailing: 0))
                }
            }.frame(width: 34, height: 34)
                .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 0))

            VStack(alignment: .leading, spacing: 3.5) {
                Text(user?.name ?? "")
                    .foregroundColor(ColorList.white_70.color)
                    .font(MyFont.getFont(.BOLD, 16))

                Text(user?.getLocation() ?? "")
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 14))
            }

            Spacer()

            Text("watch".localized())
                .foregroundColor(ColorList.white_80.color)
                .font(MyFont.getFont(.NORMAL, 16))
                .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
        }
    }
}

