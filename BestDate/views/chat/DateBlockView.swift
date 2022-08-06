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
            RoundedRectangle(cornerRadius: 13)
                .stroke(MyColor.getColor(190, 239, 255, 0.15), lineWidth: 1.5)
                .background(ColorList.main.color)
                .cornerRadius(13)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16), radius: 6, y: 3)

            Text(date)
                .foregroundColor(ColorList.white_30.color)
                .font(MyFont.getFont(.BOLD, 14))
        }.frame(width: 103, height: 26)
            .padding(.init(top: 16, leading: 0, bottom: 16, trailing: 0))
    }
}
