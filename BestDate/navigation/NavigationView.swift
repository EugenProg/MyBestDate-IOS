//
//  NavigationView.swift
//  BestDate
//
//  Created by Евгений on 07.06.2022.
//

import SwiftUI

struct NavigationView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var store: Store

    var body: some View {
        ZStack {
            VStack {
                ZStack {}.frame(width: UIScreen.main.bounds.width, height: store.state.statusBarHeight)
                    .background(store.state.statusBarColor)
                Spacer()
            }
            ZStack {
                DialogsView().zIndex(1)
                Group {
                    switch store.state.activeScreen {
                    case .START: StartScreen()
                    case .ONBOARD_START: OnboardStartScreen().transition(.opacity)
                    case .ONBOARD_SECOND: OnboardSecondScreen().transition(.move(edge: .trailing))
                    case .AUTH: AuthScreen().transition(.move(edge: .trailing))
                    case .REGISTRATION_START: RegistrationStartScreen().transition(.opacity)
                    case .REGISTRATION_CONTINUE: RegistrationContinueScreen().transition(.move(edge: .trailing))
                    case .REGISTRATION_OTP: RegistrationOtpScreen().transition(.opacity)
                    case .PASS_RECOVERY: PassRecoveryScreen().transition(.opacity)
                    case .PASS_RECOVERY_OTP: PassRecoveryOTPScreen().transition(.move(edge: .trailing))
                    case .PASS_RECOVERY_SET_NEW: PassRecoverySetNewScreen().transition(.opacity)
                    case .GEO_LOCATION: GeolocationScreen().transition(.opacity)
                    case .PROFILE_PHOTO: ProfilePhotoScreen().transition(.opacity)
                    case .PHOTO_EDITING: PhotoEditingScreen().transition(.move(edge: .bottom))
                    case .QUESTIONNAIRE: QuestionnaireScreen().transition(.move(edge: .trailing))
                    case .MAIN: MainScreen().transition(.opacity)
                    case .PROFILE: ProfileScreen().transition(.opacity)
                    case .PROFILE_IMAGES: UserProfileImageListScreen()
                    case .ANOTHER_PROFILE: AnotherProfileScreen().transition(.opacity)
                    case .TOP_LIST: TopScreen().transition(.move(edge: .trailing))
                    case .MY_DUELS: MyDuelsScreen().transition(.move(edge: .trailing))
                    case .CHAT: ChatScreen().transition(.move(edge: .trailing))
                    case .ANOTHER_QUESTIONNAIRE: AnotherProfileQuestionnaireScreen().transition(.move(edge: .trailing))
                    case .ANOTHER_IMAGES: AnotherProfileImagesScreen().transition(.opacity)
                    case .INVITATION: InvitatinsScreen().transition(.move(edge: .trailing))
                    case .MATCHES_LIST: MatchesListScreen().transition(.move(edge: .trailing))
                    case .LIKES_LIST: LikesListScreen().transition(.move(edge: .trailing))
                    case .NOTIFY_SETTINGS: NotifySettingsScreen().transition(.opacity)
                    case .SETTINGS: SettingsScreen().transition(.move(edge: .trailing))
                    case .PERSONAL_DATA: PersonalDataScreen().transition(.move(edge: .trailing))
                    case .BLACK_LIST: BlackListScreen().transition(.move(edge: .trailing))
                    case .CHANGE_PASS: ChangePasswordScreen().transition(.move(edge: .trailing))
                    case .FILL_REGISTRATION_DATA: FillRegistrationDataScreen().transition(.opacity)
                    case .SEARCH_FILTER: SearchFilterScreen().transition(.move(edge: .bottom))
                    case .USER_LOCATION: UserLocationScreen().transition(.move(edge: .bottom))
                    case .TARIFF_LIST: TariffListScreen().transition(.move(edge: .bottom))
                    }
                }.blur(radius: getBlur())
            }.onTapGesture(perform: { store.dispatch(action: .hideKeyboard) })
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(.init(top: store.state.statusBarHeight, leading: 0, bottom: 0, trailing: 0))
            .onChange(of: scenePhase) { newValue in
                if newValue != .active {
                    PusherMediator.shared.closePusherConnection()
                } else {
                    PusherMediator.shared.setStore(store: store)
                    if !UserDataHolder.shared.getRefreshToken().isEmpty {
                        CoreApiService.shared.refreshToken { _ in
                            self.updateUser()
                        }
                    }
                    if store.state.activeScreen == .MAIN &&
                        MainMediator.shared.currentScreen == .CHAT_LIST {
                        ChatListMediator.shared.chatList.removeAll()
                        ChatListMediator.shared.getChatList(withClear: true, page: 0)
                    } else if store.state.activeScreen == .CHAT {
                        ChatMediator.shared.getMessageList(withClear: true, page: 0)
                    }
                }
            }
    }

    private func updateUser() {
        CoreApiService.shared.updateLanguage(lang: "lang_code".localized()) { _, user in
            DispatchQueue.main.async {
                MainMediator.shared.setUserInfo()
                ProfileMediator.shared.setUser(user: user)
            }
        }
    }

    private func getBlur() -> CGFloat {
        store.state.showBottomSheet ||
        store.state.showMessage ||
        store.state.showMatchActionDialog ||
        store.state.showPushNotification ||
        store.state.inProcess ||
        store.state.showDeleteDialog ||
        store.state.showLanguageSettingDialog ||
        store.state.showSetPermissionDialog ||
        store.state.showMessageBunningDialog ||
        store.state.showInvitationBunningDialog ||
        store.state.showInvitationDialog ? 1.8 : 0
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
