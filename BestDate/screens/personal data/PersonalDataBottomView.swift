//
//  PersonalDataBottomView.swift
//  BestDate
//
//  Created by Евгений on 20.09.2022.
//

import SwiftUI

struct PersonalDataBottomView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        VStack(spacing: 25) {
            SettingsButtonBlockView(title: "password_change",
                                    description: "changing_the_password",
                                    buttonTitle: "new_password") {

            }.padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))

            SettingsSearchLocationButtonView(location: MainMediator.shared.user.getLocation()) {

            }.padding(.init(top: 0, leading: 0, bottom: 30, trailing: 0))
        }
    }
}

struct PersonalDataBottomView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDataBottomView()
    }
}
