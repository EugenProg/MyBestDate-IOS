//
//  SettingsSwitchView.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct SettingsSwitchView: View {
    let image: String
    let title: String

    @Binding var isActive: Bool?
    @Binding var saveProgress: Bool
    @Binding var isEnabled: Bool

    var checkAction: (Bool) -> Void

    var body: some View {
        HStack(spacing: 0) {
            Image(image)

            VStack(alignment: .leading, spacing: 0) {
                Text(NSLocalizedString(title, comment: "title"))
                    .foregroundColor(ColorList.white_80.color)
                    .font(MyFont.getFont(.BOLD, 16))

                Text(NSLocalizedString(isActive == true ? "active" : "deactive", comment: "active"))
                    .foregroundColor(isActive == true ? ColorList.light_blue.color : ColorList.pink.color)
                    .font(MyFont.getFont(.NORMAL, 16))
                    .opacity(0.9)
            }.padding(.init(top: 0, leading: 11, bottom: 0, trailing: 0))

            Spacer()

            if isActive == true {
                Text(NSLocalizedString("settings_applied", comment: "applied"))
                    .foregroundColor(ColorList.white_40.color)
                    .font(MyFont.getFont(.NORMAL, 14))
            }

            ZStack {
                ProgressView()
                    .tint(ColorList.white.color)
                    .frame(width: 25, height: 25)
                    .opacity(saveProgress ? 1 : 0)

                SwitchButtonView(isActive: $isActive, isEnabled: $isEnabled) { checked in
                    isActive = checked
                    checkAction(checked)
                }
                .frame(height: 36)
                .opacity(saveProgress ? 0 : 1)
            }
        }.frame(width: UIScreen.main.bounds.width - 48)
            .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 16))
    }
}

