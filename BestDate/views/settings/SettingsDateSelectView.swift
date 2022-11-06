//
//  SettingsDateSelectView.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import SwiftUI

struct SettingsDateSelectView: View {
    var hint: String
    var image: String

    @Binding var date: Date
    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(hint.localized())
                        .foregroundColor(ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    ZStack {
                        DatePicker("Birth date", selection: $date, in: ...Date.getEithteenYearsAgoDate(), displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(CompactDatePickerStyle())
                        .background(MyColor.getColor(0, 0, 0, 0))
                        .applyTextColor(ColorList.white.color)
                        .onChange(of: date) { newValue in
                            clickAction()
                        }
                    }
                }

                Spacer()

                Image(image)
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 42))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }
    }
}
