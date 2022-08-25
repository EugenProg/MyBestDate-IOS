//
//  TopPanelView.swift
//  BestDate
//
//  Created by Евгений on 25.08.2022.
//

import SwiftUI

struct TopPanelView: View {

    @Binding var offsetValue: CGFloat

    var clickAction: () -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 32)
                .stroke(ColorList.white_50.color, lineWidth: 2)
                .background(ColorList.chat_blue.color)
                .cornerRadius(32)

            HStack(spacing: 28) {
                Image("ic_card_pink")
                    .resizable()
                    .frame(width: 31, height: 21)

                Text(NSLocalizedString("invitation_card", comment: "title").uppercased())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 14))

                Button(action: {
                    withAnimation { clickAction() }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(ColorList.light_blue.color)
                            .frame(width: 75, height: 22)

                        Text("go_to")
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 14))
                    }
                }
            }.padding(.init(top: 0, leading: 0, bottom: 9, trailing: 0))
        }.frame(height: 115)
            .padding(.init(top: 16 + (offsetValue / 2), leading: 0, bottom: 0, trailing: 0))
    }
}

