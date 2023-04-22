//
//  ProfileAdditionaly.swift
//  BestDate
//
//  Created by Евгений on 19.02.2023.
//

import SwiftUI

struct ProfileAdditionaly: View {
    @EnvironmentObject var store: Store

    var clickAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "additionally", textSize: 28, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 13, trailing: 0))

            VStack(spacing: 8) {
                Text("share".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 20))
                    .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))

                Rectangle()
                    .fill(ColorList.white_10.color)
                    .frame(height: 1)

            }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
                .padding(.init(top: 10, leading: 18, bottom: 30, trailing: 18))
                .onTapGesture {
                    withAnimation {
                        clickAction()
                        ProfileMediator.shared.showShareSheet = true
                    }
                }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }
}

