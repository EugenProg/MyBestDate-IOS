//
//  SettingsInfoView.swift
//  BestDate
//
//  Created by Евгений on 14.09.2022.
//

import SwiftUI

struct SettingsInfoView: View {
    var hint: String
    var image: String

    @Binding var text: String

    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(hint.localized())
                        .foregroundColor(ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    Text(text)
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                }

                Spacer()

                Image(image)
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 42))
                .onTapGesture {
                    clickAction()
                }

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }
    }
}

