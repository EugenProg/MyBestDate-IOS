//
//  MyTextMessageView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct MyTextMessageView: View {
    var message: Message?
    var isLast: Bool

    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            ZStack(alignment: .trailing) {
                Text(message?.text ?? "")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .padding(.init(top: 9, leading: 18, bottom: 9, trailing: 18))
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
