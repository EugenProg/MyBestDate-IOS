//
//  SettingsInputOtpView.swift
//  BestDate
//
//  Created by Евгений on 20.09.2022.
//

import SwiftUI

struct SettingsInputOtpView: View {
    @State var input: String = ""
    var codeAction: (_ code: String) -> Void
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("confirmation_code".localized())
                        .foregroundColor(ColorList.white_50.color)
                        .font(MyFont.getFont(.NORMAL, 12))

                    TextField("", text: $input)
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.NORMAL, 18))
                        .keyboardType(.numberPad)
                        .onChange(of: input) { newValue in
                            if newValue.count > 5 {
                                codeAction(newValue)
                            }
                        }
                }

                Spacer()
            }.padding(.init(top: 0, leading: 32, bottom: 0, trailing: 42))

            Rectangle()
                .fill(ColorList.white_10.color)
                .frame(width: UIScreen.main.bounds.width - 64, height: 1)
        }
    }
}

