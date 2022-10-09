//
//  StartScreen.swift
//  BestDate
//
//  Created by Евгений on 14.07.2022.
//

import SwiftUI

struct StartScreen: View {
    @EnvironmentObject var store: Store

    var body: some View {
        ZStack {
            LottieView(name: "heart")
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))

                if UserDataHolder.startScreen != .START {
                    refreshToken()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
                        navigate(screen: .ONBOARD_START)
                    })
                }
            }
    }

    private func refreshToken() {
        if UserDataHolder.refreshToken.isEmpty {
            navigate(screen: .AUTH)
        } else {
            CoreApiService.shared.refreshToken { success in
                DispatchQueue.main.async {
                    if success {
                        getUserData()
                    } else {
                        navigate(screen: .AUTH)
                    }
                }
            }
        }
    }

    private func getUserData() {
        CoreApiService.shared.getUserData { success, user in
            DispatchQueue.main.async {
                let startScreen = UserDataHolder.startScreen
                if success {
                    if startScreen == .MAIN {
                        if languageIsNotTheSame(user: user) {
                            let newUser = changeUserLanguage(user: user, lang: NSLocalizedString("lang_code", comment: "Lang"))
                            MainMediator.shared.setUserInfo(user: newUser)
                        } else {
                            MainMediator.shared.setUserInfo(user: user)
                        }
                    } else {
                        PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                        RegistrationMediator.shared.setUserData(user: user)
                        QuestionnaireMediator.shared.setEditInfo(user: user, editMode: false)
                    }
                }
                navigate(screen: startScreen)
            }
        }
    }

    private func languageIsNotTheSame(user: UserInfo) -> Bool {
        user.language != NSLocalizedString("lang_code", comment: "Lang")
    }

    private func changeUserLanguage(user: UserInfo, lang: String) -> UserInfo {
        CoreApiService.shared.updateLanguage(lang: lang) { _ in }
        var newUser = user.copy()
        newUser.language = lang
        return newUser
    }

    private func navigate(screen: ScreenList) {
        withAnimation {
            store.dispatch(action: .navigate(screen: screen))
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
