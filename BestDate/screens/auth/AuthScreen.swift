//
//  AuthScreen.swift
//  BestDate
//
//  Created by Евгений on 06.06.2022.
//

import SwiftUI

struct AuthScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = AuthMediator.shared
    @State var process: Bool = false
    @State var emailInputError = false
    @State var emailInputText: String = ""
    @State var passInputError = false
    @State var passInputText: String = ""
    
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
                        
                        Title(textColor: ColorList.main.color, text: "hello_login_now")
                        
                        HeaderText(textColor: ColorList.main_70.color, text: "welcome_to_our_kind_and_cozy_home")
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(ColorList.main.uiColor))
                                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                            VStack(spacing: 0) {
                                StandardInputView(hint: "email_or_phone_number", imageName: "ic_message", inputText: $emailInputText, errorState: $emailInputError)
                                
                                PasswordInputView(inputText: $passInputText, errorState: $passInputError)
                                
                                SecondStylesTextButton(firstText: "forgot_password", secondText: "reset", firstTextColor: ColorList.white_60.color, secondTextColor: ColorList.white.color) {
                                    store.dispatch(action: .navigate(screen: .PASS_RECOVERY))
                                }.frame(width: UIScreen.main.bounds.width, alignment: .leading)
                                
                                StandardButton(style: .white, title: "login", loadingProcess: $process) {
                                    validate()
                                }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                                
                                SecondStylesTextButton(firstText: "don_t_have_an_account", secondText: "sign_up", firstTextColor: ColorList.white_60.color, secondTextColor: ColorList.white.color) {
                                    store.dispatch(action: .navigate(screen: .REGISTRATION_START))
                                }
                                
                                Spacer()
                            }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                        }.frame(width: UIScreen.main.bounds.width, height: 530 + store.state.statusBarHeight)
                            .padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                    }
                }
                VStack {
                    SocialView(
                        gooleClickAction: { store.dispatch(action: .show(message: "google")) },
                        appleClickAction: { store.dispatch(action: .show(message: "apple")) },
                        facebookClickAction: { store.dispatch(action: .show(message: "facebook")) })
                }.frame(height: UIScreen.main.bounds.height, alignment: .bottom)
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(ColorList.white.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.white.color, style: .darkContent))
            }
    }
    
    private func validate() {
        if emailInputText.isEmpty { setError(errorState: $emailInputError) }
        else if passInputText.count < 6 { setError(errorState: $passInputError) }
        else {
            process.toggle()
            mediator.auth(login: emailInputText, password: passInputText) { success, message in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        store.dispatch(action: .navigate(screen: .PROFILE_PHOTO))
                    } else {
                        store.dispatch(action: .show(message: NSLocalizedString(message, comment: "Message")))
                    }
                }
            }
        }
    }
}

struct AuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        AuthScreen()
    }
}
