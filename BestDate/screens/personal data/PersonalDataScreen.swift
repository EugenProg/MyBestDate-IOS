//
//  PersonalDataScreen.swift
//  BestDate
//
//  Created by Евгений on 13.09.2022.
//

import SwiftUI

struct PersonalDataScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = PersonalDataMediator.shared

    @State var saveProcess: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    BackButton(style: .white)

                    Spacer()
                }

                Title(textColor: ColorList.white.color, text: "personal_data", textSize: 20, paddingV: 0, paddingH: 0)
            }.frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 18))

            Rectangle()
                .fill(MyColor.getColor(190, 239, 255, 0.15))
                .frame(height: 1)

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 25) {
                    SettingsHeaderView(title: "general_info", description: "general_information_about_your_account")
                        .padding(.init(top: 30, leading: 0, bottom: 0, trailing: 0))

                    SettingsInputView(hint: "name", image: "ic_user", input: $mediator.name) {
                        mediator.checkChanges()
                    }

                    SettingsInfoView(hint: "gender", image: "ic_gender", text: $mediator.gender) {
                        store.dispatch(action: .showBottomSheet(view: .GENDER))
                    }

                    SettingsDateSelectView(hint: "birth_date", image: "ic_calendar", date: $mediator.birthday) {
                        mediator.checkChanges()
                    }

                    SettingsInputView(hint: "email", image: "ic_message", input: $mediator.email) {
                        mediator.checkChanges()
                    }

                    SettingsInputView(hint: "phone_number", image: "ic_phone_number", input: $mediator.phone) {
                        mediator.checkChanges()
                    }

                    SettingsSaveButtonView(saveEnabled: $mediator.saveEnable, saveProcess: $saveProcess) {
                        saveProcess.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            saveProcess.toggle()
                        }
                    }

                    SettingsButtonBlockView(title: "password_change",
                                            description: "changing_the_password",
                                            buttonTitle: "new_password") {

                    }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))

                    SettingsSearchLocationButtonView(location: MainMediator.shared.user.getLocation()) {
                        
                    }.padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
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

struct PersonalDataScreen_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataScreen()
    }
}
