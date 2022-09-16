//
//  SettingsScreen.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI
import MapKit

struct SettingsScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = SettingsMediator.shared
    @State var messageBlockingProccess: Bool = false
    @State var matchesModeSaveProgress: Bool = false
    @State var invisibilitySaveProgress: Bool = false
    @State var changesEnabled: Bool = true

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "settings", textSize: 20, paddingV: 0, paddingH: 0)
                    .onTapGesture {
                        changesEnabled.toggle()
                    }
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 30) {
                    Text(NSLocalizedString("main_settings", comment: "main").uppercased())
                        .foregroundColor(ColorList.white.color)
                        .font(MyFont.getFont(.BOLD, 22))
                        .frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
                        .padding(.init(top: 25, leading: 32, bottom: 0, trailing: 32))

                    SettingsSwitchBlockView(title: "blocking_messages",
                                            description: "you_will_not_be_able_to_send_messages",
                                            switchTitle: "messages",
                                            image: "ic_settings_message",
                                            isActive: $mediator.settings.block_messages,
                                            saveProgress: $messageBlockingProccess,
                                            isEnabled: $changesEnabled) { checked in
                        messageBlockingProccess.toggle()
                        changesEnabled = false
                        mediator.saveSettings(type: .messages, enable: checked) {
                            DispatchQueue.main.async {
                                withAnimation { messageBlockingProccess.toggle() }
                                changesEnabled = true
                            }
                        }
                    }

                    NotificationsSettingsBlockView(settings: $mediator.settings.notifications,
                                                   isEnabled: $changesEnabled)

                    SettingsButtonBlockView(title: "blocked_users",
                                            description: "a_list_of_users_who_have_been_blocked_by_you",
                                            buttonTitle: "show_the_list") {
                        BlackListMedialtor.shared.getBlockedList()
                        store.dispatch(action: .navigate(screen: .BLACK_LIST))
                    }

//                    SettingsSwitchBlockView(title: "invisibility_mode",
//                                            description: "the_ability_to_view_other_profiles",
//                                            switchTitle: "invisible",
//                                            image: "ic_settings_invisible",
//                                            isActive: $mediator.settings.matches,
//                                            saveProgress: $invisibilitySaveProgress,
//                                            isEnabled: $changesEnabled) { checked in
//
//                    }

                    SettingsSwitchBlockView(title: "participation_in_matches",
                                            description: "the_ability_to_view_other_profiles",
                                            switchTitle: "matches",
                                            image: "ic_settings_matches",
                                            isActive: $mediator.settings.matches,
                                            saveProgress: $matchesModeSaveProgress,
                                            isEnabled: $changesEnabled) { checked in
                        matchesModeSaveProgress.toggle()
                        changesEnabled = false
                        mediator.saveSettings(type: .matches, enable: checked) {
                            DispatchQueue.main.async {
                                withAnimation { matchesModeSaveProgress.toggle() }
                                changesEnabled = true
                            }
                        }
                    }

                    SettingsButtonBlockView(title: "language",
                                            description: "here_you_can_select_the_language",
                                            buttonTitle: mediator.language) {
                        store.dispatch(action: .showBottomSheet(view: .LANGUAGE))
                    }

                    SettingsButtonBlockView(title: "delete_profile",
                                            description: "this_action_will_delete_your_account",
                                            buttonTitle: "delete") {

                    }.padding(.init(top: 0, leading: 0, bottom: 23, trailing: 0))

                }
            }
            .padding(.init(top: 0, leading: 0, bottom: store.state.statusBarHeight, trailing: 0))
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
    }
}
