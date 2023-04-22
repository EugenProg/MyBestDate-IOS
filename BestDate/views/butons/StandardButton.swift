//
//  StandardButton.swift
//  BestDate
//
//  Created by Евгений on 08.06.2022.
//

import SwiftUI

struct StandardButton: View {
    var style: StandardButtonStyle
    var title: String
    @Binding var loadingProcess: Bool
    var clickAction: () -> Void
    
    var body: some View {
        Button (action: {
            if !loadingProcess { withAnimation { clickAction() } }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 33)
                    .fill(style.buttonColor)
                if loadingProcess {
                    LoadingDotsView()
                } else {
                    Text(title.localized())
                        .foregroundColor(style.contentColor)
                        .font(MyFont.getFont(.BOLD, 18))
                }
            }.frame(height: 58, alignment: .center)
                .padding(.init(top: 5, leading: 18, bottom: 5, trailing: 18))
        }
    }
    
    enum StandardButtonStyle {
        case white
        case black
        case blue
        case pink
        
        var buttonColor: Color {
            switch self {
            case .white: return ColorList.white.color
            case .black: return ColorList.main.color
            case .blue: return ColorList.light_blue.color
            case .pink: return ColorList.pink.color
            }
        }
        
        var contentColor: Color {
            switch self {
            case .white: return ColorList.main.color
            case .black: return ColorList.white.color
            case .blue: return ColorList.main.color
            case .pink: return ColorList.main.color
            }
        }
    }
}
