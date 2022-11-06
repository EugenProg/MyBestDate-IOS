//
//  PageHeaderView.swift
//  BestDate
//
//  Created by Евгений on 25.06.2022.
//

import SwiftUI

struct PageHeaderView: View {
    var title: String
    var currentNumber: Int
    var totalNumber: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            HStack(spacing: 7) {
                Text("0\(currentNumber)")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 38))

                Text("of".localized())
                    .foregroundColor(ColorList.main_60.color)
                    .font(MyFont.getFont(.BOLD, 16))
                    .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))

                Text("0\(totalNumber)")
                    .foregroundColor(ColorList.main.color)
                    .font(MyFont.getFont(.BOLD, 16))
                    .padding(.init(top: 10, leading: 0, bottom: 0, trailing: 0))
            }

            Text(title.localized())
                .foregroundColor(ColorList.main.color)
                .font(MyFont.getFont(.BOLD, 26))
        }.padding(.init(top: 13, leading: 23, bottom: 0, trailing: 23))
    }
}
