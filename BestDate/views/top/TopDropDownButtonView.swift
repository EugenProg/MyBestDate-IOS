//
//  TopDropDownButtonView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopDropDownButtonView: View {

    var style: TopDropDownButtonViewStyle
    var text: String
    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation { clickAction() }
        }) {
            ZStack {
                Rectangle()
                    .stroke(MyColor.getColor(255, 255, 255, 0.3), lineWidth: 1)
                    .background(style.backgroundColor)
                    .shadow(color: MyColor.getColor(17, 24, 28, 0.6), radius: 16, y: 3)

                Image(style.backgroundImage)
                    .padding(.init(top: 5, leading: 18, bottom: 0, trailing: 10))

                HStack(spacing: 9) {
                    Image(style.icon)

                    Text("\(style.title) \(text)")
                        .foregroundColor(style.textColor)
                        .font(MyFont.getFont(.BOLD, 14))

                    Image(style.arrow)
                }
            }.frame(width: 170, height: 34)
        }
    }
}

enum TopDropDownButtonViewStyle {
    case blue
    case pink

    var icon: String {
        switch self {
        case .blue: return "ic_black_crown"
        case .pink: return "ic_white_crown"
        }
    }

    var textColor: Color {
        switch self {
        case .blue: return ColorList.main.color
        case .pink: return ColorList.white.color
        }
    }

    var arrow: String {
        switch self {
        case .blue: return "ic_arrow_bottom_black"
        case .pink: return "ic_arrow_bottom_white"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .blue: return MyColor.getColor(148, 224, 248)
        case .pink: return ColorList.pink.color
        }
    }

    var backgroundImage: String {
        switch self {
        case .blue: return "bg_herths_blue"
        case .pink: return "bg_herths_pink"
        }
    }

    var title: String {
        switch self {
        case .blue: return "mister".localized()
        case .pink: return "miss".localized()
        }
    }
}
