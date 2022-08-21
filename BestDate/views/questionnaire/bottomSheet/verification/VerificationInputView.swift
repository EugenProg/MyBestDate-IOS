//
//  VerificationInputView.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI

struct VerificationInputView: View {
    var errorColor = ColorList.red

    var image: String
    var hint: String
    @Binding var input: String
    @Binding var isConfimed: Bool
    @Binding var errorState: Bool
    var keyboard: UIKeyboardType = .default

    var textIsChanged: ((String) -> Void)? = nil

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorList.main_5.color)

            HStack(spacing: 0) {
                Image(image)
                    .renderingMode(.template)
                    .foregroundColor(errorState ? errorColor.color : ColorList.main.color)
                    .frame(width: 24, height: 24)
                    .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 16))

                Rectangle()
                    .fill(errorState ? errorColor.color : ColorList.main_30.color)
                    .frame(width: 1, height: 41)

                ZStack(alignment: .leading) {
                    if input.isEmpty {
                        Text(NSLocalizedString(hint, comment: "hint"))
                            .foregroundColor(errorState ? errorColor.color : ColorList.main_70.color)
                            .font(MyFont.getFont(.BOLD, 20))
                    }

                    TextField("", text: $input)
                        .foregroundColor(errorState ? errorColor.color : ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .keyboardType(keyboard)
                        .onChange(of: input) { newValue in
                            if textIsChanged != nil {
                                textIsChanged!(newValue)
                            }
                            errorState = false
                        }
                }.padding(.init(top: 0, leading: 14, bottom: 0, trailing: 8))

                Image(isConfimed ? "ic_check_pink" : "ic_check_gray")
                    .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 24))
            }
        }.frame(width: UIScreen.main.bounds.width - 64, height: 76)
            .modifier(ShakeEffect(shakes: errorState ? 2 : 0))
    }
}
