//
//  SettingsHeaderView.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct SettingsHeaderView: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(NSLocalizedString(title, comment: "title"))
                .foregroundColor(ColorList.white_90.color)
                .font(MyFont.getFont(.BOLD, 20))

            Text(NSLocalizedString(description, comment: "description"))
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 20))
        }.frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
            .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}

