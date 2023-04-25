//
//  MyImageMessageView.swift
//  BestDate
//
//  Created by Евгений on 08.08.2022.
//

import SwiftUI

struct MyImageMessageView: View {
    @Binding var message: Message?
    @Binding var isLast: Bool

    var selectClick: () -> Void
    var imageClick: (ChatImage?) -> Void
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 2) {
            VStack(alignment: .leading, spacing: 0) {
                ChatImageView(message: $message)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(25)
                    .padding(.init(top: 6, leading: 6, bottom: 6, trailing: 6))
                    .onTapGesture {
                        withAnimation { imageClick(message?.image) }
                    }
                    .onLongPressGesture {
                        withAnimation { selectClick() }
                    }

                if !(message?.text?.isEmpty ?? true) {
                    Text(message?.text ?? "")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                        .padding(.init(top: 0, leading: 18, bottom: 9, trailing: 18))
                }
            }.background(
                RoundedRectangle(cornerRadius: 28)
                    .stroke(ColorList.white_50.color, lineWidth: 2)
                    .background(ColorList.chat_blue.color)
                    .cornerRadius(28)
            )
            .padding(.init(top: 0, leading: 100, bottom: 0, trailing: 18))

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
