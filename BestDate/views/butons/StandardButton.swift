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
                    ProgressView()
                        .tint(style.contentColor)
                        .frame(width: 50, height: 50)
                } else {
                    Text(NSLocalizedString(title, comment: "title"))
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
        
        var buttonColor: Color {
            switch self {
            case .white: return ColorList.white.color
            case .black: return ColorList.main.color
            }
        }
        
        var contentColor: Color {
            switch self {
            case .white: return ColorList.main.color
            case .black: return ColorList.white.color
            }
        }
    }
}
