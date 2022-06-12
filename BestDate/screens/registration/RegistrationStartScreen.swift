//
//  RegistrationStartScreen.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct RegistrationStartScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var registrationHolder = RegistrationDataHolder.shared
    
    @State var process: Bool = false
    @State var nameInputError = false
    @State var genderInputError = false
    
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
                        
                        HeaderText(textColor: ColorList.main_70.color, text: "when_creating_a_new_account_we_recommend_that_you_read_our_privacy_policy")
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(ColorList.main.uiColor))
                                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                            VStack(spacing: 0) {
                                StandardInputView(hint: "name", imageName: "ic_user", inputText: $registrationHolder.name, errorState: $nameInputError)
                                
                                InfoView(hint: "gender", imageName: "ic_gender", infoText: $registrationHolder.gender, errorState: $genderInputError) { store.dispatch(action: .showBottomSheet(view: .GENDER)) }
                                
                                DateSelectView(hint: "birth_date", imageName: "ic_calendar", date: $registrationHolder.birthDate)
                                
                                StandardButton(style: .white, title: "next", loadingProcess: $process) {
                                    validate()
                                }.padding(.init(top: 16, leading: 0, bottom: 25, trailing: 0))
                                
                                SecondStylesTextButton(firstText: "already_have_in_account", secondText: "login", firstTextColor: ColorList.white_60.color, secondTextColor: ColorList.white.color) {
                                    store.dispatch(action: .navigate(screen: .AUTH))
                                }
                                
                                Spacer()
                            }.padding(.init(top: 25, leading: 0, bottom: 0, trailing: 0))
                        }.frame(width: UIScreen.main.bounds.width, height: 590 + store.state.statusBarHeight)
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
        if registrationHolder.name.isEmpty { nameInputError = true }
        else if registrationHolder.gender.isEmpty { genderInputError = true }
        else { store.dispatch(action: .navigate(screen: .REGISTRATION_CONTINUE)) }
    }
}

struct RegistrationStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationStartScreen()
    }
}
