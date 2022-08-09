//
//  CompanionTextMessageWithParentView.swift
//  BestDate
//
//  Created by Евгений on 05.08.2022.
//

import SwiftUI

struct CompanionTextMessageWithParentView: View {
    @Binding var message: Message?
    @Binding var isLast: Bool
    @Binding var parentMessage: Message?
    var topOffset: CGFloat
    var bottomOffset: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 8) {
                        Image("ic_reply_black")

                        if parentMessage?.image != nil {
                            ChatImageView(message: $parentMessage)
                                .aspectRatio(contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .frame(width: 35, height: 35)
                                .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
                        }

                        Text(parentMessage?.text ?? "")
                            .foregroundColor(ColorList.main_70.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .lineLimit(3)
                    }

                    Text(message?.text ?? "")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                }.padding(.init(top: 12, leading: 18, bottom: 12, trailing: 18))
                    .background(
                        VStack {
                            Rectangle()
                                .fill(MyColor.getColor(40, 48, 52, 0.11))
                                .frame(height: 1)
                        }.padding(.init(top: parentMessage?.image != nil && topOffset < 35 ? 45 : topOffset, leading: 18, bottom: bottomOffset, trailing: 18))
                    )


            }.background(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(ColorList.chat_blue_55.color, lineWidth: 2)
                    .background(ColorList.white.color)
                    .cornerRadius(28)
            )
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 60))

            if isLast {
                Text(message?.created_at?.getTime() ?? "???")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.NORMAL, 14))
                    .padding(.init(top: 0, leading: 41, bottom: 10, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}
