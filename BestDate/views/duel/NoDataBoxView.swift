//
//  NoDuelData.swift
//  BestDate
//
//  Created by Евгений on 28.07.2022.
//

import SwiftUI

struct NoDataBoxView: View {
    @Binding var loadingMode: Bool
    var text: String

    var body: some View {
        ZStack {
            if loadingMode {
                LoadingDotsView()
                    .frame(minHeight: 80)
            } else {
                Text(text.localized())
                    .foregroundColor(ColorList.white.color)
                    .multilineTextAlignment(.center)
                    .font(MyFont.getFont(.BOLD, 22))
                    .lineSpacing(5)
                    .padding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
            }
        }.frame(width: UIScreen.main.bounds.width - 36)
            .background(MyColor.getColor(41, 50, 54))
    }
}
