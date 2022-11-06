//
//  SettingsSearchLocationButtonView.swift
//  BestDate
//
//  Created by Евгений on 14.09.2022.
//

import SwiftUI

struct SettingsSearchLocationButtonView: View {
    var location: String
    var clickAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SettingsHeaderView(title: "search_location", description: "specify_the_place_where_you_want_to_search")

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("location".localized())
                        .foregroundColor(ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    Text(location)
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                }

                Spacer()

                Image("ic_settings_location")
            }.padding(.init(top: 20, leading: 32, bottom: 0, trailing: 32))

            Button(action: {
                withAnimation { clickAction() }
            }) {
                Text("change_location".localized())
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 14))
                    .padding(.init(top: 7, leading: 24, bottom: 6, trailing: 24))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(ColorList.white.color)
                    )
            }.padding(.init(top: 20, leading: 32, bottom: 15, trailing: 0))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
                .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 0))
        }
    }
}
