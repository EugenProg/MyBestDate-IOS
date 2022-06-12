//
//  RegistrationContinueScreen.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct RegistrationContinueScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var registrationHolder = RegistrationDataHolder.shared
    
    @State var process: Bool = false
    @State var emailInputError = false
    @State var passInputError = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Rectangle()
                        .fill(ColorList.main.color)
                        .frame(height: UIScreen.main.bounds.height / 3)
                }.frame(height: UIScreen.main.bounds.height, alignment: .bottom)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {
                        BackButton(style: .black)
                            .padding(.init(top: 32, leading: 32, bottom: 15, trailing: 0))
                        
                        Title(textColor: ColorList.main.color, text: "one_step_to_your_dream")
                        
                        HeaderText(textColor: ColorList.main_70.color, text: "by_clicking_the_sign_up_button_you_agree_to_our_privacy_policy_and_terms_of_use")
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(ColorList.main.uiColor))
                                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                            VStack(spacing: 0) {
                                HStack(spacing: 25) {
                                    Image("ic_hearts")
                                    VStack(alignment: .leading, spacing: 1) {
                                        Text(registrationHolder.name)
                                            .foregroundColor(ColorList.white.color)
                                            .font(MyFont.getFont(.BOLD, 26))
                                        
                                        Text(registrationHolder.birthDate.toString())
                                            .foregroundColor(ColorList.white_80.color)
                                            .font(MyFont.getFont(.BOLD, 16))
                                            
                                        Text(registrationHolder.gender)
                                            .foregroundColor(ColorList.white_60.color)
                                            .font(MyFont.getFont(.BOLD, 16))
                                            .padding(.init(top: 16, leading: 0, bottom: 0, trailing: 0))
                                    }
                                    Spacer()
                                }.padding(.init(top: 10, leading: 32, bottom: 32, trailing: 32))
                                
                                StandardInputView(hint: "email_or_phone_number", imageName: "ic_message", inputText: $registrationHolder.email, errorState: $emailInputError, inputType: .emailAddress)
                                
                                PasswordInputView(inputText: $registrationHolder.password, errorState: $passInputError)
                                
                                StandardButton(style: .white, title: "create_account", loadingProcess: $process) {
                                    validate()
                                }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                                
                                Spacer()
                            }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                        }.frame(width: UIScreen.main.bounds.width, height: 590 + store.state.statusBarHeight)
                            .padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                    }
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
        if registrationHolder.email.isEmpty { emailInputError = true }
        else if registrationHolder.password.count < 6 { passInputError = true }
        else { store.dispatch(action: .navigate(screen: .REGISTRATION_OTP)) }
    }
}

struct RegistrationContinueScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationContinueScreen()
    }
}
