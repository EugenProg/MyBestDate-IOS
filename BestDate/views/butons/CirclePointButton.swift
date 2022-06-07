//
//  CirclePointButton.swift
//  BestDate
//
//  Created by Евгений on 07.06.2022.
//

import SwiftUI

struct CirclePointButton: View {
    var withOpacityRing: Bool
    var clickAction: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation{ clickAction() }
        }) {
            ZStack {
                if withOpacityRing {
                    Circle()
                        .fill(Color(ColorList.main_10.uiColor))
                        .frame(width: 38, height: 38)
                }
                let size = withOpacityRing ? 16.0 : 8.0
                Circle()
                    .fill(Color(ColorList.main.uiColor))
                    .frame(width: size, height: size)
            }
        }
    }
}

struct CirclePointButton_Previews: PreviewProvider {
    static var previews: some View {
        CirclePointButton(withOpacityRing: false) { }
    }
}
