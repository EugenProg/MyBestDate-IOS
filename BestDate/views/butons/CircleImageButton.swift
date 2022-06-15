//
//  CircleImageButton.swift
//  BestDate
//
//  Created by Евгений on 07.06.2022.
//

import SwiftUI

struct CircleImageButton: View {
    var imageName: String
    var strokeColor: UIColor
    var shadowColor: Color
    var circleSize: CircleSize = .LARGE
    var clickAction: () -> Void
    
    
    var body: some View {
        Button(action: {
            withAnimation{ clickAction() }
        }) {
            ZStack {
                Circle()
                    .stroke(Color(strokeColor), lineWidth: 1)
                    .frame(width: circleSize.size, height: circleSize.size)
                    .background(Color(ColorList.main.uiColor))
                    .cornerRadius(circleSize.size / 2)
                    .shadow(color: shadowColor, radius: 6, y: 3)
                Image(imageName)
            }
        }
    }
}

struct CircleImageButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageButton(imageName: "", strokeColor: .white, shadowColor: .pink) { }
    }
}

enum CircleSize: String {
    case SMALL
    case LARGE
    
    var size: CGFloat {
        switch self {
        case .SMALL: return 44
        case .LARGE: return 56
        }
    }
}
