//
//  NavigationView.swift
//  BestDate
//
//  Created by Евгений on 07.06.2022.
//

import SwiftUI

struct NavigationView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        ZStack {
            VStack {
                ZStack {}.frame(width: UIScreen.main.bounds.width, height: store.state.statusBarHeight)
                    .background(store.state.statusBarColor)
                Spacer()
            }
            ZStack {
                if store.state.showBottomSheet { BaseBottomSheet().zIndex(1) }
                Group {
                    switch store.state.activeScreen {
                    case .ONBOARD_START: OnboardStartScreen()
                    case .ONBOARD_SECOND: OnboardSecondScreen().transition(.move(edge: .trailing))
                    case .AUTH: AuthScreen().transition(.move(edge: .trailing))
                    case .REGISTRATION_START: RegistrationStartScreen()
                    case .REGISTRATION_CONTINUE: RegistrationContinueScreen()
                    case .REGISTRATION_OTP: RegistrationOtpScreen()
                    default: RegistrationStartScreen()
                    }
                }.blur(radius: store.state.showBottomSheet ? 1.8 : 0)
            }.onTapGesture(perform: { UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true) })
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .padding(.init(top: store.state.statusBarHeight, leading: 0, bottom: 0, trailing: 0))
            .alert(store.state.notificationText, isPresented: $store.state.showMessage) {
                        Button("OK", role: .cancel) { }
                    }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
