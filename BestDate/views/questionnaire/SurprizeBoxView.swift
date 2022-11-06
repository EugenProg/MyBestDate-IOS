//
//  SurprizeBoxView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct SurprizeBoxView: View {
    @Binding var checked: Bool

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .stroke(MyColor.getColor(228, 145, 224, 0.1), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(16)
                .shadow(color: MyColor.getColor(0, 0, 0, 0.16), radius: 6, y: 3)

            if checked {
                Image("ic_check_pink")
            } else {
                HStack(spacing: 4) {
                    Image("ic_surprize")

                    Text("surprise".localized())
                        .foregroundColor(ColorList.pink.color)
                        .font(MyFont.getFont(.BOLD, 12))
                }
            }
        }.frame(width: checked ? 23 : 79, height: 23)
    }
}
