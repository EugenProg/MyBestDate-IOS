//
//  TopButtonView.swift
//  BestDate
//
//  Created by Евгений on 21.07.2022.
//

import SwiftUI

struct TopButtonView: View {

    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(ColorList.main.color)
                    .shadow(color: MyColor.getColor(17, 24, 28), radius: 16, y: 3)

                HStack(spacing: 11) {
                    Image("ic_arrow_right_blue")
                        .rotationEffect(Angle(degrees: 180))

                    Image("ic_duel")

                    DuelColorfullTitle()
                }
                .padding(.init(top: 0, leading: 12, bottom: 0, trailing: 18))
            }.frame(width: 129, height: 39)
        }
    }
}

struct TopButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TopButtonView { }
    }
}
