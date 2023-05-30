//
//  ToSettingsButton.swift
//  BestDate
//
//  Created by Евгений on 31.05.2023.
//

import SwiftUI

struct ToSettingsButton: View {
    var backColor: Color = ColorList.main.color
    var shadowColor: Color = MyColor.getColor(17, 24, 28, 0.6)

    var body: some View {
        HStack(spacing: 14) {
            Image("ic_setting")
                .padding(.leading, 24)

            Text("settings".localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 14))

            Image("ic_arrow_right_blue")
                .padding(.trailing, 24)
        }.frame(height: 42)
            .background(
                RoundedRectangle(cornerRadius: 21)
                    .fill(backColor)
                    .shadow(color: shadowColor, radius: 12, y: 3)
            )
    }
}

struct ToSettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        ToSettingsButton()
    }
}
