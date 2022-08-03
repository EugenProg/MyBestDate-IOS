//
//  DateBlockView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct DateBlockView: View {
    var date: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .stroke(ColorList.chat_blue_55.color, lineWidth: 2)
                .background(ColorList.white.color)
                .cornerRadius(28)

            Text(date)
                .foregroundColor(MyColor.getColor(40, 48, 52))
                .font(MyFont.getFont(.NORMAL, 16))
        }.frame(width: 100, height: 35)
    }
}
