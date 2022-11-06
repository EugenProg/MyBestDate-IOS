//
//  ChangePassword.swift
//  BestDate
//
//  Created by Евгений on 22.09.2022.
//

import SwiftUI

struct ChangePasswordScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = ChangePasswordMediator.shared

    @State var oldPassError: Bool = false
    @State var newPassError: Bool = false
    @State var confirmPassError: Bool = false

    @State var saveProccess: Bool = false

    @State var oldPass: String = ""
    @State var newPass: String = ""
    @State var confirmPass: String = ""

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)
                    
                    Spacer()
                }
                
                Title(textColor: ColorList.white.color, text: "change_password", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))
            
            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)
            
            VStack(spacing: 30) {
                ChangePasswordInputView(hint: "enter_a_old_pass", errorState: $oldPassError, input: $oldPass)

                ChangePasswordInputView(hint: "enter_a_new_password", errorState: $newPassError, input: $newPass)

                ChangePasswordInputView(hint: "confirm_the_new_pass", errorState: $confirmPassError, input: $confirmPass)

                StandardButton(style: .white, title: "save", loadingProcess: $saveProccess) {
                    validate()
                }

                Spacer()
            }.padding(.init(top: 30, leading: 0, bottom: 0, trailing: 0))
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }

    private func validate() {
        if oldPass.count < 6 { oldPassError = true }
        else if newPass.count < 6 { newPassError = true }
        else if confirmPass.count < 6 || newPass != confirmPass { confirmPassError = true }
        else {
            saveProccess.toggle()
            mediator.saveNewPassword(oldPass: oldPass, newPass: newPass) { success, message in
                DispatchQueue.main.async {
                    saveProccess.toggle()
                    if success {
                        showSuccessMessage()
                        withAnimation { store.dispatch(action: .navigationBack) }
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }
            }
        }
    }

    private func showSuccessMessage() {
        let successMessage = "save_successfully".localized()
        store.dispatch(action: .show(message: successMessage))
    }
}
