//
//  GenderBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct GenderBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var registrationHolder = RegistrationMediator.shared
    var clickAction: () -> Void
    
    var genderList: [String] =
    ["woman_looking_for_a_man",
     "woman_looking_for_a_woman",
     "man_looking_for_a_man",
     "man_looking_for_a_woman"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "gender", textSize: 28, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))
            
            ForEach(genderList, id: \.self) { gender in
                GnderListItem(text: gender) { item in
                    clickAction()
                    if store.state.activeScreen == .REGISTRATION_START { registrationHolder.gender = item }
                    if store.state.activeScreen == .PERSONAL_DATA { PersonalDataMediator.shared.setGender(gender: item) }
                    if store.state.activeScreen == .FILL_REGISTRATION_DATA { FillRegistrationDataMediator.shared.setGender(gender: item) }
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }
}

