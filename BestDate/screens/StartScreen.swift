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

                if UserDataHolder.shared.getStartScreen() != .START {
                    refreshToken()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.6, execute: {
                        navigate(screen: .ONBOARD_START)
                    })
                }
            }
    }

    private func refreshToken() {
        if UserDataHolder.shared.getRefreshToken().isEmpty {
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
        CoreApiService.shared.updateLanguage(lang: "lang_code".localized()) { success, user in
            DispatchQueue.main.async {
                let startScreen = UserDataHolder.shared.getStartScreen()
                if success {
                    if startScreen == .MAIN {
                        MainMediator.shared.setUserInfo()
                        ProfileMediator.shared.setUser(user: user)
                    } else {
                        PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                        RegistrationMediator.shared.setUserData(user: user)
                        QuestionnaireMediator.shared.setEditInfo(user: user, editMode: false)
                    }
                    SubscriptionApiService.shared.getAppSettings()
                    SubscriptionApiService.shared.getUserSubscriptionInfo()
                    CoreApiService.shared.getUserSettings { _, _ in }
                    CoreApiService.shared.storeDeviceToken(token: UserDataHolder.shared.getNotificationToken())
                }
                navigate(screen: startScreen)
            }
        }
    }

    private func languageIsNotTheSame(user: UserInfo) -> Bool {
        user.language != "lang_code".localized()
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
