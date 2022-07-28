//
//  ToTopListButton.swift
//  BestDate
//
//  Created by Евгений on 28.07.2022.
//

import SwiftUI

struct ToTopListButton: View {

    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            clickAction()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .fill(ColorList.main.color)
                    .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)

                HStack(spacing: 12) {
                    Image("ic_menu_top_active")

                    Text("top_50")
                        .foregroundColor(ColorList.light_blue.color)
                        .font(MyFont.getFont(.BOLD, 14))

                    Image("ic_arrow_right_blue")
                }
            }.frame(width: 121, height: 39)
        }
    }
}
