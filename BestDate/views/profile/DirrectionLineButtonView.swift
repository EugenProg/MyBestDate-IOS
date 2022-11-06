//
//  DirrectionLineButtonView.swift
//  BestDate
//
//  Created by Евгений on 17.07.2022.
//

import SwiftUI

struct DirrectionLineButtonView: View {
    var name: String
    var icon: String
    var buttonColor: Color

    var clickAction: () -> Void
    @State var proccess: Bool = false

    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                    .background(buttonColor)
                    .cornerRadius(16)

                Image(icon)
            }.frame(width: 46, height: 46)

            Text(name.localized())
                .foregroundColor(ColorList.white_90.color)
                .font(MyFont.getFont(.BOLD, 16))

            Spacer()

            CircleImageButton(imageName: "ic_arrow_right_white", strokeColor: MyColor.getColor(190, 239, 255, 0.18), shadowColor: MyColor.getColor(80, 110, 126, 0.63), circleSize: .LARGE, loadingProcess: $proccess) {
                clickAction()
            }
        }.frame(height: 56)
            .background(ColorList.main.color)
            .padding(.init(top: 8, leading: 18, bottom: 8, trailing: 18))
            .onTapGesture {
                withAnimation { clickAction() }
            }
    }
}

