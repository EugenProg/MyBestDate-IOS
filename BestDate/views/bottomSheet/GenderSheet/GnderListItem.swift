//
//  GnderListItem.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import SwiftUI

struct GnderListItem: View {
    var text: String
    var clickAction: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(NSLocalizedString(text, comment: "text"))
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 20))
                .padding(.init(top: 0, leading: 14, bottom: 0, trailing: 14))
            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(height: 1)
            
        }.frame(width: UIScreen.main.bounds.width - 36, height: 61)
            .padding(.init(top: 0, leading: 18, bottom: 0, trailing: 18))
            .onTapGesture {
                clickAction(text)
            }
    }
}
