//
//  SettingsSwitchBlockView.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct SettingsSwitchBlockView: View {
    let title: String
    let description: String
    let switchTitle: String
    let image: String
    @Binding var isActive: Bool?
    @Binding var saveProgress: Bool
    @Binding var isEnabled: Bool
    @State var activeText: String = "active".localized()
    @State var unactiveText: String = "deactive".localized()

    var checkAction: (Bool) -> Void

    var body: some View {
        VStack(spacing: 0) {
            SettingsHeaderView(title: title, description: description)

            SettingsSwitchView(image: image, title: switchTitle, activeText: activeText, unactiveText: unactiveText, isActive: $isActive, saveProgress: $saveProgress, isEnabled: $isEnabled) { checked in
                isActive = checked
                checkAction(checked)
            }.padding(.init(top: 20, leading: 0, bottom: 15, trailing: 0))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }
    }
}

