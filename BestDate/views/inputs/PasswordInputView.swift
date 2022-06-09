//
//  PasswordInputView.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct PasswordInputView: View {
    var errorColor = ColorList.red
    @State var passVisibility: Bool = false
    
    var hint: String = "password"
    @Binding var inputText: String
    @Binding var errorState: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color(errorState ? errorColor.uiColor : MyColor.getColor(231, 238, 242, 0.12)), lineWidth: 1)
                .background(ColorList.main.color)
                .cornerRadius(24)
    
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(NSLocalizedString(hint, comment: "hint"))
                        .foregroundColor(errorState ? errorColor.color : ColorList.white_60.color)
                        .font(MyFont.getFont(.NORMAL, 12))
                    if passVisibility {
                        TextField("", text: $inputText)
                            .onChange(of: inputText) { text in
                                setDefault()
                            }
                            .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 20))
                    } else {
                        SecureField("", text: $inputText)
                            .onChange(of: inputText) { text in
                                setDefault()
                            }
                            .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                            .font(MyFont.getFont(.BOLD, 20))
                    }
                }
                Button(action: {
                    withAnimation { passVisibility.toggle() } })
                {
                    Image(passVisibility ? "ic_eye" : "ic_eye_slash")
                        .renderingMode(.template)
                        .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                }
            }.padding(.init(top: 18, leading: 27, bottom: 16, trailing: 24))
            
        }
        .modifier(ShakeEffect(shakes: errorState ? 2 : 0))
        .frame(height: 76)
        .padding(.init(top: 13, leading: 18, bottom: 12, trailing: 18))
    }
    
    private func setDefault() {
        errorState = false
    }
}
