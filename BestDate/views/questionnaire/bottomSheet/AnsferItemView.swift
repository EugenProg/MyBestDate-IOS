//
//  AnsferItemView.swift
//  BestDate
//
//  Created by Евгений on 28.06.2022.
//

import SwiftUI

struct AnsferItemView: View {
    var ansfer: String
    var isSelect: Bool
    var clickAction: (String) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorList.white.color)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0) {
                    Text(NSLocalizedString(ansfer, comment: "text"))
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .lineLimit(1)

                    Spacer()

                    if  isSelect {
                        Image("ic_check_black")
                    } else {
                        Image("ic_check_gray")
                    }
                }.padding(.init(top: 0, leading: 14, bottom: 0, trailing: 14))

                Rectangle()
                    .fill(ColorList.main_10.color)
                    .frame(height: 1)

            }
        }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            .onTapGesture {
                withAnimation {
                    clickAction(NSLocalizedString(ansfer, comment: "ansfer"))
                }
            }

    }
}
