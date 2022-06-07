//
//  CircleImageButton.swift
//  BestDate
//
//  Created by Евгений on 07.06.2022.
//

import SwiftUI

struct CircleImageButton: View {
    var imageName: String
    var strokeColor: Color
    var shadowColor: Color
    var clickAction: () -> Void
    
    
    var body: some View {
        Button(action: {
            withAnimation{ clickAction() }
        }) {
            ZStack {
                Circle()
                    .stroke(Color(ColorList.pink_18.uiColor), lineWidth: 1)
                    .frame(width: 56, height: 56)
                    .background(Color(ColorList.main.uiColor))
                    .cornerRadius(56)
                    .shadow(color: shadowColor, radius: 46, y: 23)
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
