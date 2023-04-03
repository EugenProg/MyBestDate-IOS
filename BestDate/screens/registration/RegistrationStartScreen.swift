//
//  RegistrationStartScreen.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct RegistrationStartScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = RegistrationMediator.shared
    @ObservedObject var authMediator = AuthMediator.shared
    @ObservedObject var socialMediator = SocialSignInMediator.shared
    
    @State var process: Bool = false
    @State var nameInputError = false
    @State var genderInputError = false
    @State var termsOfUseError = false
    @State var privacyPolicyError = false
    @State var termsOfUseSelect = false
    @State var privacyPolicySelect = false
    
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
                        
                        Title(textColor: ColorList.main.color, text: "create_new_account")
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(ColorList.main.uiColor))
                                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                            VStack(spacing: 0) {
                                StandardInputView(hint: "name", imageName: "ic_user", inputText: $mediator.name, errorState: $nameInputError)
                                
                                InfoView(hint: "gender", imageName: "ic_gender", infoText: $mediator.gender, errorState: $genderInputError) { store.dispatch(action: .showBottomSheet(view: .GENDER)) }
                                
                                DateSelectView(hint: "birth_date", imageName: "ic_calendar", date: $mediator.birthDate)

                                CheckBoxView(linkText: "terms_of_use", isSelect: $termsOfUseSelect, errorState: $termsOfUseError) {
                                    store.dispatch(action: .openLink(link: "\(CoreApiTypes.serverAddress)/use-agreement"))
                                }

                                CheckBoxView(linkText: "privacy_policy", isSelect: $privacyPolicySelect, errorState: $privacyPolicyError) {
                                    store.dispatch(action: .openLink(link: "\(CoreApiTypes.serverAddress)/privacy-policy"))
                                }
                                
                                StandardButton(style: .white, title: "next", loadingProcess: $process) {
                                    validate()
                                }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                                
                                SecondStylesTextButton(firstText: "already_have_in_account", secondText: "login", firstTextColor: ColorList.white_60.color, secondTextColor: ColorList.white.color) {
                                    store.dispatch(action: .navigate(screen: .AUTH))
                                }
                                
                                Spacer()
                            }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                        }.frame(width: UIScreen.main.bounds.width, height: 700 + store.state.statusBarHeight)
                    }
                }
                VStack {
                    SocialView(
                        gooleClickAction: { loginSocial(provider: .google) },
                        appleClickAction: { loginSocial(provider: .apple) },
                        facebookClickAction: { loginSocial(provider: .facebook) }
                    )
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
        if mediator.name.isEmpty { nameInputError = true }
        else if mediator.gender.isEmpty { genderInputError = true }
        else if !termsOfUseSelect { termsOfUseError = true }
        else if !privacyPolicySelect { privacyPolicyError = true }
        else { store.dispatch(action: .navigate(screen: .REGISTRATION_CONTINUE)) }
    }

    private func goIn(success: Bool, registrationMode: Bool, message: String) {
        store.dispatch(action: .endProcess)
        if success {
            if !authMediator.hasFullData {
                UserDataHolder.setStartScreen(screen: .FILL_REGISTRATION_DATA)
            } else if !authMediator.hasImages {
                UserDataHolder.setStartScreen(screen: .PROFILE_PHOTO)
            } else if !authMediator.hasQuestionnaire {
                UserDataHolder.setStartScreen(screen: .QUESTIONNAIRE)
            } else {
                UserDataHolder.setStartScreen(screen: .MAIN)
            }
            withAnimation {
                store.dispatch(action: .navigate(screen: UserDataHolder.startScreen))
            }
        } else {
            store.dispatch(action: .show(message: message.localized()))
        }
    }

    private func loginSocial(provider: SocialOAuthType) {
        socialMediator.loginSocial(provider: provider) { success, registrationMode in
            if success {
                DispatchQueue.main.async { store.dispatch(action: .startProcess) }
                authMediator.getUserData { success in
                    DispatchQueue.main.async {
                        goIn(success: success, registrationMode: registrationMode, message: "default_error_message".localized())
                    }
                }
            } else {
                DispatchQueue.main.async {
                    store.dispatch(action:
                            .show(message: "default_error_message".localized()))
                }
            }
        }
    }
}

struct RegistrationStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationStartScreen()
    }
}
