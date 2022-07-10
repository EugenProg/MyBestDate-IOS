//
//  DropDownView.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct DropDownView: View {

    var style: DropDownViewStyle
    @State var text: String
    var clickAction: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .stroke(style.borderColor, lineWidth: 1)
                .background(ColorList.main.color)
                .shadow(color: style.shadowColor, radius: 16, y: 3)

            Image(style.image)
                .padding(.init(top: 0, leading: 101, bottom: 0, trailing: 13))

            Text(NSLocalizedString(text, comment: "Text"))
                .foregroundColor(style.textColor)
                .font(MyFont.getFont(.BOLD, 14))
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 10))
        }.frame(width: 125, height: 34)
            .onTapGesture {
                withAnimation { clickAction() }
            }
    }
}

enum DropDownViewStyle {
    case blue
    case gray

    var textColor: Color {
        switch self {
        case .blue: return ColorList.blue_1.color
        case .gray: return ColorList.white_30.color
        }
    }

    var image: String {
        switch self {
        case .blue: return "ic_arrow_bottom_blue"
        case .gray: return "ic_arrow_bottom_gray"
        }
    }

    var borderColor: Color {
        switch self {
        case .blue: return MyColor.getColor(118, 207, 255, 0.04)
        case .gray: return MyColor.getColor(255, 255, 255, 0.06)
        }
    }

    var shadowColor: Color {
        switch self {
        case .blue: return MyColor.getColor(17, 24, 28, 0.6)
        case .gray: return MyColor.getColor(17, 24, 28, 0.35)
        }
    }
}
