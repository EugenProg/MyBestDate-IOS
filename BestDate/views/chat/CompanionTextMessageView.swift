//
//  CompanionTextMessageView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct CompanionTextMessageView: View {
    @Binding var message: Message?
    @Binding var isLast: Bool

    var translateClick: (Message?) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 14) {
                ZStack(alignment: .leading) {
                    Text(message?.translatedMessage ?? message?.text ?? "")
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                        .padding(.init(top: 9, leading: 18, bottom: 9, trailing: 18))
                }.background(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(ColorList.chat_blue_55.color, lineWidth: 2)
                        .background(ColorList.white.color)
                        .cornerRadius(28)
                )

                MessageTranslateButtonView(message: $message) {
                    translateClick(message)
                }
            }
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))


            if isLast {
                Text(message?.created_at?.getTime() ?? "???")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.NORMAL, 14))
                    .padding(.init(top: 0, leading: 41, bottom: 10, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }
}
