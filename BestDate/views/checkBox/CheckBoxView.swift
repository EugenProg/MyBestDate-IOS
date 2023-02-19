//
//  CheckBoxView.swift
//  BestDate
//
//  Created by Евгений on 19.02.2023.
//

import SwiftUI

struct CheckBoxView: View {
    @State var linkText: String
    @Binding var isSelect: Bool
    @Binding var errorState: Bool
    var linkClick: (() -> Void)? = nil

    fileprivate func checkButton() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(errorState ? ColorList.red.color : MyColor.getColor(231, 238, 242, 0.12), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(12)

            Image("ic_check_pink")
                .opacity(isSelect ? 1 : 0)
        }.frame(width: 32, height: 32)
    }

    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                withAnimation { isSelect.toggle() }
                errorState = false
            }) {
                checkButton()
            }

            Button(action: {
                if linkClick != nil { linkClick!() }
            }) {
                Text("i_agree_and_accept".localized())
                    .foregroundColor(errorState ? ColorList.red.color : (isSelect ? ColorList.white.color : ColorList.white_70.color))
                    .font(MyFont.getFont(.NORMAL, 16)) +
                Text(linkText.localized())
                    .foregroundColor(errorState ? ColorList.red.color : (isSelect ? ColorList.white.color : ColorList.white_70.color))
                    .font(MyFont.getFont(.NORMAL, 16))
                    .underline()
            }

            Spacer()
        }
        .modifier(ShakeEffect(shakes: errorState ? 2 : 0))
        .padding(.init(top: 10, leading: 18, bottom: 10, trailing: 18))
    }
}

