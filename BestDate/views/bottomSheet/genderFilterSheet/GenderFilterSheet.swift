//
//  GenderFilterSheet.swift
//  BestDate
//
//  Created by Евгений on 02.04.2023.
//

import SwiftUI

struct GenderFilterSheet: View {
    @EnvironmentObject var store: Store
    var clickAction: () -> Void

    var genderList: [FilterGender] = [.men, .women, .all_gender]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "gender", textSize: 32, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(genderList, id: \.self) { gender in
                DarkBottomSheetItem(text: gender.getName, isSelect: equals(gender: gender)) { item in
                    store.dispatch(action: .startProcess)
                    SearchMediator.shared.setGender(gender: gender) {
                        DispatchQueue.main.async {
                            store.dispatch(action: .endProcess)
                        }
                    }
                    clickAction()
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }

    private func equals(gender: FilterGender) -> Bool {
        gender == SearchMediator.shared.selectedGender
    }
}

enum FilterGender {
    case men
    case women
    case all_gender

    var getName: String {
        switch self {
        case .men: return "mans"
        case .women: return "womans"
        case .all_gender: return "all_genders"
        }
    }

    var getServerName: String? {
        switch self {
        case .men: return "male"
        case .women: return "female"
        case .all_gender: return nil
        }
    }
}
