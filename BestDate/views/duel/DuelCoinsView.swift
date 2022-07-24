//
//  DuelCoinsContainer.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct DuelCoinsView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 23)
                .fill(ColorList.main.color)
                .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
                .frame(width: 153, height: 45)

            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 27)
                        .stroke(ColorList.main.color, lineWidth: 6)
                        .background(MyColor.getColor(26, 44, 74))
                        .cornerRadius(27)
                        .shadow(color: MyColor.getColor(17, 24, 28), radius: 16, y: 0.6)
                        .frame(width: 54, height: 54)

                    Image("ic_coin_bd_mini")
                }

                VStack(spacing: 1) {
                    Text("10.14")
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 16))

                    Text("BD Coin")
                        .foregroundColor(ColorList.white_80.color)
                        .font(MyFont.getFont(.NORMAL, 10))
                }

                Spacer()
            }
        }.frame(width: 153)
    }
}

struct DuelCoinsContainer_Previews: PreviewProvider {
    static var previews: some View {
        DuelCoinsView()
    }
}
