//
//  CoinsBox.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import SwiftUI

struct CoinsBoxView: View {
    var coinsCount: Int
    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                    .background(ColorList.white_5.color)
                    .cornerRadius(16)

                HStack(spacing: 8) {
                    Image("ic_coin_bd_mini")

                    Text("\(coinsCount)")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 28))

                    Text("BD Coin")
                        .foregroundColor(ColorList.white_80.color)
                        .font(MyFont.getFont(.BOLD, 12))
                }
            }.frame(width: 184, height: 58, alignment: .leading)
        }
    }
}
