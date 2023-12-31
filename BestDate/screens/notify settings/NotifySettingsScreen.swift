//
//  NotifySettingsScreen.swift
//  BestDate
//
//  Created by Евгений on 31.08.2022.
//

import SwiftUI

struct NotifySettingsScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = NotifySettingsMediator.shared

    @State var process: Bool = false
    @State var notificationEnbaled: Bool? = false

    var body: some View {
        ZStack {
            VStack {
                Image("ic_splash_decor")

                Spacer()
            }.ignoresSafeArea()

            ZStack {
                Image("ic_settings_hearts")
                    .padding(.init(top: 0, leading: 16, bottom: 0, trailing: 0))

                Image("ic_logoName")
                    .resizable()
                    .frame(width: 248, height: 49)
                    .padding(.init(top: 0, leading: 0, bottom: 110, trailing: 0))
            }.padding(.init(top: 80, leading: 32, bottom: UIScreen.main.bounds.height - 330, trailing: 16))
            
            VStack {
                HStack {
                    Spacer()

                    Button(action: {
                        UserDataHolder.shared.setStartScreen(screen: .MAIN)
                        withAnimation { store.dispatch(action: .navigate(screen: .MAIN)) }
                    }) {
                        Text("cancel".localized())
                            .foregroundColor(ColorList.white.color)
                            .font(MyFont.getFont(.NORMAL, 18))
                    }.padding(16)
                }.padding(.init(top: 20, leading: 32, bottom: 0, trailing: 32))


                Text("this_will_be_your_best_date".localized().uppercased())
                    .foregroundColor(ColorList.white_70.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.init(top: 210, leading: 32, bottom: 8, trailing: 32))

                Text("we_are_for_live_communication".localized())
                    .foregroundColor(ColorList.white.color)
                    .font(MyFont.getFont(.BOLD, 28))
                    .padding(.init(top: 9, leading: 32, bottom: 8, trailing: 32))

                Text("if_you_turn_off_the_chat, then_you_can_only_be_called_on_a_date".localized())
                    .foregroundColor(ColorList.white_70.color)
                    .font(MyFont.getFont(.NORMAL, 18))
                    .multilineTextAlignment(.center)
                    .frame(width: 286)
                    .padding(.init(top: 9, leading: 0, bottom: 0, trailing: 0))

                Spacer()

                VStack(alignment: .leading, spacing: 0) {
                    Text("or_everyone_can_write_to_you".localized())
                        .foregroundColor(ColorList.white_70.color)
                        .font(MyFont.getFont(.NORMAL, 18)) +
                    Text("settings".localized().lowercased())
                        .foregroundColor(ColorList.pink.color)
                        .font(MyFont.getFont(.BOLD, 18))
                }.frame(width: UIScreen.main.bounds.width - 64, alignment: .leading)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

                NotifySettingsSelectorView(isActive: $notificationEnbaled) { _ in }

                Spacer()

                StandardButton(style: .white, title: "get_started", loadingProcess: $process) {
                    process.toggle()
                    mediator.saveSettings(enable: notificationEnbaled ?? false) {
                        DispatchQueue.main.async {
                            process.toggle()
                            UserDataHolder.shared.setStartScreen(screen: .MAIN)
                            withAnimation { store.dispatch(action: .navigate(screen: .MAIN)) }
                        }
                    }
                }
                .frame(width: 230)

                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
        .onAppear {
            store.dispatch(action:
                    .setScreenColors(status: ColorList.main.color, style: .lightContent))
        }
    }
}

struct NotifySettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotifySettingsScreen()
    }
}
