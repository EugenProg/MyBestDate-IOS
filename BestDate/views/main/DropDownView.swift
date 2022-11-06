//
//  DropDownView.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct DropDownView: View {

    var style: DropDownViewStyle
    @Binding var text: String
    var clickAction: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .stroke(style.borderColor, lineWidth: 1)
                .background(ColorList.main.color)
                .shadow(color: style.shadowColor, radius: 16, y: 3)

            HStack(spacing: 2) {
                Text(text.localized())
                    .foregroundColor(style.textColor)
                    .font(MyFont.getFont(.BOLD, 14))
                    .lineLimit(1)

                Spacer()

                Image(style.image)
            }.frame(width: 105)
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
