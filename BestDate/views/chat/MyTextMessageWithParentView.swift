//
//  MyTextMessageWithParent.swift
//  BestDate
//
//  Created by Евгений on 04.08.2022.
//

import SwiftUI

struct MyTextMessageWithParentView: View {
    var message: Message?
    var parentMessage: Message?
    var isLast: Bool
    var topOffset: CGFloat
    var bottomOffset: CGFloat

    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            ZStack(alignment: .trailing) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 8) {
                        Image("ic_reply_white")

                        Text(parentMessage?.text ?? "")
                            .foregroundColor(ColorList.white_70.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .lineLimit(3)
                    }

                    Text(message?.text ?? "")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                }.padding(.init(top: 12, leading: 18, bottom: 12, trailing: 18))
                    .background(
                        VStack {
                            Rectangle()
                                .fill(MyColor.getColor(244, 248, 250, 0.5))
                                .frame(height: 1)
                        }.padding(.init(top: topOffset, leading: 18, bottom: bottomOffset, trailing: 18))
                    )


            }.background(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(ColorList.white_50.color, lineWidth: 2)
                    .background(ColorList.chat_blue.color)
                    .cornerRadius(28)
            )
            .padding(.init(top: 0, leading: 60, bottom: 0, trailing: 18))

            if isLast {
                HStack(spacing: 3) {
                    Image(message?.read_at == nil ? "ic_message_un_checked" : "ic_message_checked")

                    Text(message?.created_at?.getTime() ?? "???")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 14))
                }.padding(.init(top: 0, leading: 60, bottom: 10, trailing: 32))
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .trailing)
    }
}
