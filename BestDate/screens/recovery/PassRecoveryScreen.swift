//
//  PassRecoveryScreen.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import SwiftUI

struct PassRecoveryScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = RecoveryMediator.shared
    
    @State var process: Bool = false
    @State var emailInputError: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    BackButton(style: .black)
                        .padding(.init(top: 32, leading: 32, bottom: 15, trailing: 0))
                    
                    Title(textColor: ColorList.main.color, text: "password_recovery")
                    
                    HeaderText(textColor: ColorList.main_70.color, text: "specify_the_email_or_phone_number_that_was_entered_earlier_during_registration")
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(ColorList.main.uiColor))
                            .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                        VStack(spacing: 0) {
                            StandardInputView(hint: "email_or_phone_number", imageName: "ic_message", inputText: $mediator.login, errorState: $emailInputError, inputType: .emailAddress)
                            
                            StandardButton(style: .white, title: "next", loadingProcess: $process) {
                                validate()
                            }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                            
                            Spacer()
                        }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                    }.frame(width: UIScreen.main.bounds.width)
                        .padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.white.color, style: .darkContent))
            }
    }
    
    private func validate() {
        if mediator.login.isEmpty { emailInputError = true }
        else {
            process.toggle()
            mediator.sendCode { success, message in
                process.toggle()
                DispatchQueue.main.async {
                    if success {
                        withAnimation { store.dispatch(action: .navigate(screen: .PASS_RECOVERY_OTP)) }
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }

            }
        }
    }
}

struct PassRecoveryScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassRecoveryScreen()
    }
}
