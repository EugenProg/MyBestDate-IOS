//
//  Title.swift
//  BestDate
//
//  Created by Евгений on 09.06.2022.
//

import SwiftUI

struct Title: View {
    var textColor: Color
    var text: String
    var textSize: CGFloat = 38
    var paddingV: CGFloat = 10
    var paddingH: CGFloat = 32
    
    var body: some View {
        Text(text.localized())
            .foregroundColor(textColor)
            .font(MyFont.getFont(.BOLD, textSize))
            .padding(.init(top: paddingV, leading: paddingH, bottom: paddingV, trailing: paddingH))
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(textColor: ColorList.pink.color, text: "Title", textSize: 10)
    }
}
