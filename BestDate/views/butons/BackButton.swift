//
//  BackButton.swift
//  BestDate
//
//  Created by Евгений on 08.06.2022.
//

import SwiftUI

struct BackButton: View {
    @EnvironmentObject var store: Store
    var style: BackButtonStyle
    var clickAction: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            withAnimation {
                if clickAction != nil { clickAction!() }
                else { store.dispatch(action: .navigationBack) }
            }
        }) {
            HStack(spacing: 7) {
                Image(style.arrow)
                Text("back")
                    .foregroundColor(style.textColor)
                    .font(MyFont.getFont(.NORMAL, 18))
            }
        }
    }
    
    enum BackButtonStyle {
        case white
        case black
        
        var arrow: String {
            switch self {
            case .white: return "ic_arrow_left_white"
            case .black: return "ic_arrow_left_black"
            }
        }
        
        var textColor: Color {
            switch self {
            case .white: return ColorList.white.color
            case .black: return ColorList.main.color
            }
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(style: .black)
    }
}
