//
//  MatchesDisabledView.swift
//  BestDate
//
//  Created by Евгений on 21.05.2023.
//

import SwiftUI

struct MatchesDisabledView: View {

    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Image("ic_menu_match_active")
                .resizable()
                .frame(width: 62, height: 45)

            Text("matches".localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 28))
                .padding(.top, 14)

            Text("not_activated".localized().uppercased())
                .foregroundColor(ColorList.pink.color)
                .font(MyFont.getFont(.NORMAL, 14))
                .padding(.top, 2)

            Text("you_can_not_see_the_matches".localized())
                .foregroundColor(ColorList.white_90.color)
                .font(MyFont.getFont(.NORMAL, 16))
                .multilineTextAlignment(.center)
                .padding(.top, 22)

            Button {
                withAnimation {
                    clickAction()
                }
            } label: {
                toSettingsButton()
            }.padding(.top, 98)

            Text("you_need_to_go_to_settings".localized())
                .foregroundColor(ColorList.white_50.color)
                .font(MyFont.getFont(.NORMAL, 14))
                .multilineTextAlignment(.center)
                .padding(.top, 24)
        }.frame(width: UIScreen.main.bounds.width - 64, height: 434)
            .background(
                Rectangle()
                    .stroke(MyColor.getColor(255, 255, 255, 0.24), lineWidth: 1)
                    .background(ColorList.main.color)
            )
    }

    fileprivate func toSettingsButton() -> some View {
        HStack(spacing: 14) {
            Image("ic_setting")
                .padding(.leading, 24)

            Text("settings".localized())
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 14))

            Image("ic_arrow_right_blue")
                .padding(.trailing, 24)
        }.frame(height: 42)
            .background(
                RoundedRectangle(cornerRadius: 21)
                    .fill(ColorList.main.color)
                    .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)
            )
    }
}
