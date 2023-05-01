//
//  PassRecoverySetNewScreen.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import SwiftUI

struct PassRecoverySetNewScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = RecoveryMediator.shared
    @ObservedObject var authMediator = AuthMediator.shared
    
    @State var process: Bool = false
    @State var passInputError: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    BackButton(style: .black)
                        .padding(.init(top: 32, leading: 32, bottom: 15, trailing: 0))
                    
                    Title(textColor: ColorList.main.color, text: "set_new_password")
                    
                    HeaderText(textColor: ColorList.main_70.color, text: "create_a_new_password_for_your_profile_password_must_be_at_least_6_characters")
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(ColorList.main.uiColor))
                            .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                        VStack(spacing: 0) {
                            PasswordInputView(hint: "enter_a_new_password", inputText: $mediator.newPass, errorState: $passInputError)
                            
                            StandardButton(style: .white, title: "install_and_login", loadingProcess: $process) {
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
        if mediator.newPass.isEmpty { passInputError = true }
        else {
            process.toggle()
            mediator.confirm { success, message in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        goIn(success: success, registrationMode: false, message: message)
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }
            }
        }
    }

    private func goIn(success: Bool, registrationMode: Bool, message: String) {
        store.dispatch(action: .endProcess)
        if success {
            var startScreen: ScreenList = .MAIN
            if !authMediator.hasFullData {
                startScreen = .FILL_REGISTRATION_DATA
            } else if !authMediator.hasImages {
                startScreen = .PROFILE_PHOTO
            } else if !authMediator.hasQuestionnaire {
                startScreen = .QUESTIONNAIRE
            }
            withAnimation {
                UserDataHolder.shared.setStartScreen(screen: startScreen)
                store.dispatch(action: .navigate(screen: startScreen))
            }
        } else {
            store.dispatch(action: .show(message: message.localized()))
        }
    }
}

struct PassRecoverySetNewScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassRecoverySetNewScreen()
    }
}
