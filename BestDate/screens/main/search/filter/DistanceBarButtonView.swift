//
//  DistanceBarButtonView.swift
//  BestDate
//
//  Created by Евгений on 12.10.2022.
//

import SwiftUI

struct DistanceBarButtonView: View {
    @Binding var number: Int
    var buttonSize: CGFloat = 54
    var circleSize: CGFloat = 36

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: buttonSize / 2)
                .fill(ColorList.white_13.color)

            RoundedRectangle(cornerRadius: circleSize / 2)
                .fill(ColorList.white.color)
                .frame(width: circleSize, height: circleSize)

            Text("\(number)")
                .foregroundColor(ColorList.main.color)
                .font(MyFont.getFont(.BOLD, 16))
        }.frame(width: buttonSize, height: buttonSize)
    }
}
