//
//  CompanionImageMessageView.swift
//  BestDate
//
//  Created by Евгений on 09.08.2022.
//

import SwiftUI

struct CompanionImageMessageView: View {
    @Binding var message: Message?
    @Binding var isLast: Bool

    var selectClick: () -> Void
    var imageClick: (Message?) -> Void

    var translateClick: (Message?) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 0) {
                    ChatImageView(message: $message)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(25)
                        .padding(.init(top: 6, leading: 6, bottom: 6, trailing: 6))
                        .onTapGesture {
                            withAnimation { imageClick(message) }
                        }
                        .onLongPressGesture {
                            withAnimation { selectClick() }
                        }

                    if textIsNotEmpty() {
                        Text(message?.translatedMessage ?? message?.text ?? "")
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .padding(.init(top: 0, leading: 18, bottom: 9, trailing: 18))
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(ColorList.chat_blue_55.color, lineWidth: 2)
                        .background(ColorList.white.color)
                        .cornerRadius(28)
                )

                if textIsNotEmpty() {
                    MessageTranslateButtonView(message: $message) {
                        translateClick(message)
                    }
                }
            }
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: textIsNotEmpty() ? 18 : 60))

            if isLast {
                Text(message?.created_at?.getTime() ?? "???")
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.NORMAL, 14))
                    .padding(.init(top: 0, leading: 41, bottom: 10, trailing: 0))
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }

    private func textIsNotEmpty() -> Bool {
        message?.text?.isEmpty != true && message?.text != nil
    }
}
