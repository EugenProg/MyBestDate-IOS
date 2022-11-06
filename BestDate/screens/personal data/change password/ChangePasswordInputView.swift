//
//  ChangePasswordInputView.swift
//  BestDate
//
//  Created by Евгений on 22.09.2022.
//

import SwiftUI

struct ChangePasswordInputView: View {
    var hint: String
    var errorColor = ColorList.red
    @State var passVisibility: Bool = false
    @Binding var errorState: Bool

    @Binding var input: String

    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(hint.localized())
                        .foregroundColor(errorState ? errorColor.color : ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    if passVisibility {
                        TextField("", text: $input)
                            .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .onChange(of: input) { newValue in
                                errorState = false
                            }
                    } else {
                        SecureField("", text: $input)
                            .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                            .onChange(of: input) { newValue in
                                errorState = false
                            }
                    }
                }

                Spacer()

                Button(action: {
                    withAnimation { passVisibility.toggle() }
                }) {
                    Image(passVisibility ? "ic_eye" : "ic_eye_slash")
                        .renderingMode(.template)
                        .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                }
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 42))

            Rectangle()
                .fill(errorState ? errorColor.color : ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }.modifier(ShakeEffect(shakes: errorState ? 2 : 0))
    }
}
