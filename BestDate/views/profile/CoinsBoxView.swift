//
//  CoinsBox.swift
//  BestDate
//
//  Created by Евгений on 16.07.2022.
//

import SwiftUI

struct CoinsBoxView: View {
    @Binding var coinsCount: Int
    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 2.5) {
            Button(action: {
                withAnimation { clickAction() }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                        .background(ColorList.white_5.color)
                        .cornerRadius(16)

                    VStack(spacing: 0) {
                        Image("ic_coin_bd_mini")

                        Text(coinsCount.toString())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 20))
                    }
                }.frame(width: 88, height: 58, alignment: .leading)
            }

            Text("balance".localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 10))
        }
    }
}
