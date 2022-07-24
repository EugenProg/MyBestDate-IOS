//
//  topBottomButton.swift
//  BestDate
//
//  Created by Евгений on 21.07.2022.
//

import SwiftUI

struct TopBottomButtonView: View {

    var  clickAction: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(ColorList.main.color)
                .shadow(color: MyColor.getColor(17, 24, 28, 0.63), radius: 46, y: -7)

            HStack(spacing: 11) {
                Image("ic_duel")

                DuelColorfullTitle()

                Button(action: {
                    withAnimation { clickAction() }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(ColorList.light_blue.color)

                        Text("Go To")
                            .foregroundColor(ColorList.main.color)
                            .font(MyFont.getFont(.BOLD, 14))
                    }.frame(width: 75, height: 22)
                }
                .padding(.init(top: 0, leading: 22, bottom: 0, trailing: 0))
            }
            .padding(.init(top: 13, leading: 22, bottom: 90, trailing: 23))
        }.frame(width: 236, height: 133, alignment: .top)
    }
}

