//
//  HeaderText.swift
//  BestDate
//
//  Created by Евгений on 09.06.2022.
//

import SwiftUI

struct HeaderText: View {
    var textColor: Color
    var text: String
    var textSize: CGFloat = 18
    
    var body: some View {
        Text(text.localized())
            .foregroundColor(textColor)
            .font(MyFont.getFont(.NORMAL, textSize))
            .lineSpacing(5)
            .padding(.init(top: 10, leading: 32, bottom: 10, trailing: 32))
    }
}

struct HeaderText_Previews: PreviewProvider {
    static var previews: some View {
        HeaderText(textColor: ColorList.blue.color, text: "text")
    }
}
