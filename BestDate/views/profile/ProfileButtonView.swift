//
//  ProfileButtonView.swift
//  BestDate
//
//  Created by Евгений on 20.07.2022.
//

import SwiftUI

struct ProfileButtonView: View {
    var name: String
    var image: String
    var isActive: Bool
    var size: CGSize = CGSize(width: 61, height: 58)

    var clickAction: () -> Void

    var body: some View {
        VStack(spacing: 2.5) {
            Button(action: {
                withAnimation {
                    clickAction()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                        .background(ColorList.white_5.color)
                        .cornerRadius(16)

                    Image(image)

                    if isActive {
                        VStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(ColorList.pink.color)
                                .frame(width: 8, height: 8)
                        }.frame(width: 57, height: 54, alignment: .topTrailing)
                    }
                }.frame(width: size.width, height: size.height)
            }

            Text(NSLocalizedString(name, comment: "Name"))
                .foregroundColor(ColorList.white.color)
                .font(MyFont.getFont(.BOLD, 10))
        }
    }
}
