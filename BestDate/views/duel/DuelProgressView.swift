//
//  DuelProgressView.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct DuelProgressView: View {
    var progress: Double
    var length = UIScreen.main.bounds.width - 187

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(LinearGradient(gradient: Gradient(colors: [
                    MyColor.getColor(48, 58, 62),
                    MyColor.getColor(43, 52, 56)
                ]), startPoint: .top, endPoint: .bottom))

            let percent = (length - 6) / 100

            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(ColorList.pink.color)
                    .shadow(color: MyColor.getColor(87, 0, 53, 0.3), radius: 6, y: 3)
                    .frame(width: percent * progress, height: 8)

                Spacer()
            }.padding(.init(top: 0, leading: 3, bottom: 0, trailing: 0))
        }.frame(width: length, height: 14, alignment: .leading)
    }
}
