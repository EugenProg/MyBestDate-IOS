//
//  PhoneVerificationView.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI

struct PhoneVerificationView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = VerificationMediator.shared

    @State var input: String = ""
    @State var isConfirmed: Bool = false
    @State var loadingProcess: Bool = false
    @State var codeIsSend: Bool = false
    @State var emailIsChanged: Bool = true

    @State var phoneError: Bool = false

    @State var code: String = ""

    var body: some View {
        VStack(spacing: 0) {
            VerificationInputView(image: "ic_phone", hint: "phone_number", input: $input, isConfimed: $isConfirmed, errorState: $phoneError, keyboard: .phonePad)
                .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            if codeIsSend {
                VerificationOtpInputView(otpInput: $code) { code in
                    sendOtp(code: code)
                }.padding(.init(top: 16, leading: 32, bottom: 0, trailing: 32))
            }

            if !isConfirmed {
                StandardButton(style: .black, title: codeIsSend ? "confirm" : "save", loadingProcess: $loadingProcess) {
                    if !codeIsSend {
                        validate()
                    } else {
                        sendOtp(code: code)
                    }
                }.padding(.init(top: 16, leading: 8, bottom: 0, trailing: 8))
            }
        }
        .onAppear {
            input = mediator.questionInfo.selectedAnsfer
            isConfirmed = !mediator.questionInfo.selectedAnsfer.isEmpty
        }
    }

    private func validate() {
        if input.isEmpty || input.count < 12 {
            phoneError = true
        } else {
            mediator.getPhoneCode(phone: input) { success, message in
                DispatchQueue.main.async {
                    withAnimation { codeIsSend = success }
                    if !success { store.dispatch(action: .show(message: message)) }
                }
            }
        }
    }

    private func sendOtp(code: String) {
        mediator.confirmPhone(phone: input, code: code) { success, message in
            DispatchQueue.main.async {
                withAnimation {
                    isConfirmed = success
                    codeIsSend = !success
                }
                if !success { store.dispatch(action: .show(message: message)) }
            }
        }
    }
}
