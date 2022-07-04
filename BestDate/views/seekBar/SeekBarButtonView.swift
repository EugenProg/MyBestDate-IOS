//
//  SeekBarButtonView.swift
//  BestDate
//
//  Created by Евгений on 30.06.2022.
//

import SwiftUI

struct SeekBarButtonView: View {
    @Binding var number: Int
    var buttonSize: CGFloat = 68
    var circleSize: CGFloat = 46

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: buttonSize / 2)
                .fill(ColorList.main_10.color)

            RoundedRectangle(cornerRadius: circleSize / 2)
                .fill(ColorList.main.color)
                .frame(width: circleSize, height: circleSize)

            Text("\(number)")
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 20))
        }.frame(width: buttonSize, height: buttonSize)
    }
}
