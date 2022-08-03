//
//  CompanionTextMessageView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct CompanionTextMessageView: View {
    var message: Message?
    var isLast: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack(alignment: .leading) {
                Text(message?.text ?? "")
                    .foregroundColor(MyColor.getColor(40, 48, 52))
                    .font(MyFont.getFont(.NORMAL, 18))
                    .padding(.init(top: 9, leading: 18, bottom: 9, trailing: 18))
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
