//
//  BlackListItemView.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import SwiftUI

struct BlackListItemView: View {
    @Binding var user: ShortUserInfo?
    @State var saveProcess: Bool = false

    var clickAction: (_ id: Int) -> Void

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                UserImageView(user: $user)
                    .clipShape(Circle())

                Circle()
                    .fill(user?.is_online == true ? ColorList.green.color : ColorList.white_60.color)
                    .frame(width: 7, height: 7)
                    .padding(.init(top: 22, leading: 23, bottom: 0, trailing: 0))
            }.frame(width: 32, height: 32)
                .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 13))

            VStack(alignment: .leading, spacing: 1) {
                Text(user?.name ?? "")
                    .foregroundColor(ColorList.white_90.color)
                    .font(MyFont.getFont(.BOLD, 14))

                Text("this_user_is_blocked".localized())
                    .foregroundColor(ColorList.white_50.color)
                    .font(MyFont.getFont(.NORMAL, 12))
            }

            Spacer()

            Button(action: {
                if !saveProcess {
                    withAnimation {
                        saveProcess = true
                        clickAction(user?.id ?? 0)
                    }
                }
            }) {
                if saveProcess {
                    ProgressView()
                        .tint(ColorList.main.color)
                        .frame(width: 20, height: 20)
                } else {
                    Text("unblock".localized())
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 14))
                        .padding(.init(top: 7, leading: 24, bottom: 6, trailing: 24))
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(ColorList.white.color)
                        )
                }
            }.padding(.init(top: 0, leading: 0, bottom: 0, trailing: 18))
        }
        .frame(width: UIScreen.main.bounds.width, height: 72)
        .background(MyColor.getColor(28, 38, 43))
    }
}
