//
//  EmailVerficationView.swift
//  BestDate
//
//  Created by Евгений on 17.08.2022.
//

import SwiftUI

struct EmailVerficationView: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = VerificationMediator.shared

    @State var input: String = ""
    @State var isConfirmed: Bool = false
    @State var loadingProcess: Bool = false
    @State var codeIsSend: Bool = false
    @State var emailIsChanged: Bool = true

    @State var emailError: Bool = false

    @State var code: String = ""

    var body: some View {
        VStack(spacing: 0) {
            VerificationInputView(image: "ic_message_black", hint: "enter_email", input: $input, isConfimed: $isConfirmed, errorState: $emailError, keyboard: .emailAddress)
                .padding(.init(top: 0, leading: 32, bottom: 0, trailing: 32))

            if codeIsSend {
                VerificationOtpInputView(otpInput: $code) { code in
                    mediator.confirmEmail(email: input, code: code) { success, message in
                        DispatchQueue.main.async {
                            isConfirmed = success
                            codeIsSend = !success
                            if !success { store.dispatch(action: .show(message: message)) }
                        }
                    }
                }.padding(.init(top: 16, leading: 32, bottom: 0, trailing: 32))
            }

            if !isConfirmed {
                StandardButton(style: .black, title: codeIsSend ? "confirm" : "save", loadingProcess: $loadingProcess) {
                    if !codeIsSend {
                        validate()
                    } else {
                        mediator.confirmEmail(email: input, code: code) { success, message in
                            DispatchQueue.main.async {
                                isConfirmed = success
                                codeIsSend = !success
                                if !success { store.dispatch(action: .show(message: message)) }
                            }
                        }
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
        if input.isEmpty || !input.contains("@") {
            emailError = true
        } else {
            mediator.getEmailCode(email: input) { success, message in
                DispatchQueue.main.async {
                    withAnimation { codeIsSend = success }
                    if !success { store.dispatch(action: .show(message: message)) }
                }
            }
        }
    }
}

