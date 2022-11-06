//
//  SettingsSaveButtonView.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import SwiftUI

struct SettingsSaveButtonView: View {
    @Binding var saveEnabled: Bool
    @Binding var saveProcess: Bool
    var clickAction: () -> Void

    var body: some View {
        ZStack(alignment: .leading) {
            Button(action: {
                if saveEnabled && !saveProcess {
                    withAnimation { clickAction() }
                }
            }) {
                if saveProcess {
                    ProgressView()
                        .tint(ColorList.white.color)
                        .frame(width: 20, height: 20)
                } else {
                    Text("save_persoanl_data".localized())
                        .foregroundColor(saveEnabled ? ColorList.white.color : ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 14))
                        .padding(.init(top: 0, leading: 6, bottom: 0, trailing: 6))
                }
            }.frame(minWidth: 154, minHeight: 30)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(saveEnabled ? ColorList.pink.color : ColorList.white_30.color)
                )
        }.frame(width: UIScreen.main.bounds.width - 64, height: 30, alignment: .leading)

    }
}
