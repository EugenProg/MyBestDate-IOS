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
    
    var body: some View {
        Text(NSLocalizedString(text, comment: "title"))
            .foregroundColor(textColor)
            .font(MyFont.getFont(.BOLD, textSize))
            .padding(.init(top: 10, leading: 32, bottom: 10, trailing: 32))
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title(textColor: ColorList.pink.color, text: "Title", textSize: 10)
    }
}
