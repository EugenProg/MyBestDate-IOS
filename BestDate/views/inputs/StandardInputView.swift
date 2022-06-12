//
//  StandardInputView.swift
//  BestDate
//
//  Created by Евгений on 09.06.2022.
//

import SwiftUI

struct StandardInputView: View {
    var errorColor = ColorList.red
    
    var hint: String
    var imageName: String? = nil
    @Binding var inputText: String
    @Binding var errorState: Bool
    var inputType: UIKeyboardType = .default
    
    var textIsChanged: ((String) -> Void)? = nil
    
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
                    TextField("", text: $inputText)
                        .onChange(of: inputText) { text in
                            if textIsChanged != nil { textIsChanged!(text) }
                            setDefault()
                        }
                        .foregroundColor(errorState ? errorColor.color : ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .keyboardType(inputType)
                }
                if imageName != nil {
                    Image(imageName!)
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
