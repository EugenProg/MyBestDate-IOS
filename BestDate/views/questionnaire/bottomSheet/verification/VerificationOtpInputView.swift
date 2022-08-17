//
//  VerificationOtpInputView.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI

struct VerificationOtpInputView: View {

    @Binding var otpInput: String
    var readyAction: (String) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .fill(ColorList.main_5.color)

            HStack(spacing: 0) {
                ZStack(alignment: .leading) {
                    if otpInput.isEmpty {
                        Text(NSLocalizedString("enter_the_confirmation_code", comment: "hint"))
                            .foregroundColor(ColorList.main_70.color)
                            .font(MyFont.getFont(.BOLD, 20))
                    }

                    TextField("", text: $otpInput)
                        .foregroundColor(ColorList.main.color)
                        .font(MyFont.getFont(.BOLD, 20))
                        .keyboardType(.numberPad)
                        .onChange(of: otpInput) { value in
                            if value.count > 6 {
                                otpInput = String(otpInput.prefix(6))
                            } else if value.count == 6 {
                                readyAction(otpInput)
                            }
                        }
                }.padding(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
        }.frame(width: UIScreen.main.bounds.width - 64, height: 76)
    }
}
