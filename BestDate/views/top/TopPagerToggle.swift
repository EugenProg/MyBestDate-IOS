//
//  SwiftUIView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopPagerToggle: View {

    @Binding var activeType: GenderType
    var activeColor: Color = ColorList.white.color
    var unactiveColor: Color = ColorList.white_50.color

    fileprivate func button(type: GenderType) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .fill(LinearGradient(gradient: Gradient(colors: [
                    MyColor.getColor(48, 58, 62),
                    MyColor.getColor(43, 52, 56)
                ]), startPoint: .topLeading, endPoint: .bottomTrailing))

            VStack(alignment: .leading, spacing: 0) {
                Text(type.title)
                    .foregroundColor(activeType == type ? activeColor : unactiveColor)
                    .font(MyFont.getFont(.BOLD, 14))

                if activeType == type {
                    Image(type.icon)

                }
            }.padding(.init(top: activeType == type ? 3 : 0, leading: 0, bottom: 0, trailing: 0))
        }.frame(width: 78, height: 34)
    }

    var body: some View {
        HStack(spacing: 9) {
            Button(action: {
                if activeType == .man {
                    withAnimation { activeType = .woman }
                }
            }) {
                button(type: .woman)
            }

            Button(action: {
                if activeType == .woman {
                    withAnimation { activeType = .man }
                }
            }) {
                button(type: .man)
            }
        }
    }
}

enum GenderType {
    case man
    case woman

    var title: String {
        switch self {
        case .man: return NSLocalizedString("man", comment: "Man")
        case .woman: return NSLocalizedString("woman", comment: "Woman")
        }
    }

    var icon: String {
        switch self {
        case .man: return "ic_active_blue"
        case .woman: return "ic_active_pink"
        }
    }

    var typeName: String {
        switch self {
        case .man: return "male"
        case .woman: return "female"
        }
    }
}
