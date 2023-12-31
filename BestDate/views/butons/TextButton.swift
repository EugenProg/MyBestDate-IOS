//
//  TextButton.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct TextButton: View {
    var text: String
    var textColor: Color
    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            Text(text.localized())
                .foregroundColor(textColor)
                .font(MyFont.getFont(.NORMAL, 18))
        }
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(text: "Skip", textColor: ColorList.white.color) { }
    }
}
