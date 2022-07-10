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
    @Binding var loadingProcess: Bool
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

                if loadingProcess {
                    ProgressView()
                        .tint(ColorList.white.color)
                        .frame(width: 50, height: 50)
                } else {
                    Image(imageName)
                }
            }
        }
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

    var progressSize: CGFloat {
        switch self {
        case .SMALL: return 35
        case .LARGE: return 45
        }
    }
}
