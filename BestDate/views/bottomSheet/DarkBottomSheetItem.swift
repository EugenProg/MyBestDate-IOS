//
//  DarkBottomSheetItem.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct DarkBottomSheetItem: View {
    var text: String
    var isSelect: Bool
    var clickAction: (String) -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorList.main.color)

            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 0) {
                    Text(NSLocalizedString(text, comment: "text"))
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .lineLimit(1)

                    Spacer()

                    if  isSelect {
                        Image("ic_check_white")
                    } else {
                        Image("ic_check_gray")
                    }
                }.padding(.init(top: 0, leading: 14, bottom: 0, trailing: 14))

                Rectangle()
                    .fill(ColorList.white_10.color)
                    .frame(height: 1)

            }
        }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            .onTapGesture {
                withAnimation {
                    clickAction(NSLocalizedString(text, comment: "text"))
                }
            }
    }
}
