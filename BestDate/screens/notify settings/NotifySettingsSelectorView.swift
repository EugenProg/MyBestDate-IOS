//
//  NotifySettingsSelectorView.swift
//  BestDate
//
//  Created by Евгений on 01.09.2022.
//

import SwiftUI

struct NotifySettingsSelectorView: View {
    @Binding var isActive: Bool?
    var showInfoImage: Bool = true

    var checkAction: (Bool) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(isActive == true ? ColorList.light_blue.color : MyColor.getColor(231, 238, 242, 0.12), lineWidth: 2)
                .background(ColorList.main.color)
                .cornerRadius(24)

            HStack {
                Image(isActive == true ? "ic_message_active" : "ic_message_unactive")

                VStack(alignment: .leading, spacing: 3) {
                    Text(NSLocalizedString("prohibit_incoming_messages", comment: "hint"))
                        .foregroundColor(isActive == true ? ColorList.white.color : ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 16))
                    Text(NSLocalizedString(isActive == true ? "active" : "deactive", comment: "text"))
                        .foregroundColor(isActive == true ? ColorList.light_blue.color : ColorList.pink.color)
                        .font(MyFont.getFont(.NORMAL, 16))
                }

                Spacer()

                SwitchButtonView(isActive: $isActive) { checked in
                    checkAction(checked)
                    isActive = checked
                }

            }.padding(.init(top: 0, leading: 24, bottom: 0, trailing: 8))

        }.frame(width: UIScreen.main.bounds.width - 36, height: 76)
            .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
    }
}

