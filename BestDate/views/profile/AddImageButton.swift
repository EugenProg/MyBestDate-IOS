//
//  AddImageButton.swift
//  BestDate
//
//  Created by Евгений on 28.07.2022.
//

import SwiftUI

struct AddImageButton: View {
    var height: CGFloat
    var clickAction: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                clickAction()
            }
        }) {
            ZStack {
                Rectangle()
                    .fill(ColorList.white_10.color)

                Rectangle()
                    .fill(ColorList.white.color)
                    .frame(width: 15, height: 3)

                Rectangle()
                    .fill(ColorList.white.color)
                    .frame(width: 3, height: 15)
            }.frame(width: height, height: height)
        }
    }
}
