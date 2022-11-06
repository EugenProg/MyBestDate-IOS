//
//  SecondStylesTextButton.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct SecondStylesTextButton: View {
    var firstText: String
    var secondText: String
    var firstTextColor: Color
    var secondTextColor: Color
    var clickAction: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            HStack(spacing: 12) {
                Text(firstText.localized())
                    .foregroundColor(firstTextColor)
                    .font(MyFont.getFont(.NORMAL, 16))
                
                Text(secondText.localized())
                    .foregroundColor(secondTextColor)
                    .font(MyFont.getFont(.BOLD, 16))
            }.padding(.init(top: 10, leading: 45, bottom: 10, trailing: 45))
        }
    }
}

struct SecondStylesTextButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondStylesTextButton(firstText: "first", secondText: "second", firstTextColor: ColorList.white_60.color, secondTextColor: ColorList.white.color) { }
    }
}
