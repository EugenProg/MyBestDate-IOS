//
//  MainLocationBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct MainLocationBottomSheet: View {
    @ObservedObject var mediator = LocationMediator.shared

    var clickAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "location", textSize: 32, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(mediator.itemList, id: \.id) { item in
                DarkBottomSheetItem(text: item.name, isSelect: equals(item: item.name)) { name in
                    clickAction()
                    mediator.selectedItem = item
                    UserDataHolder.setSettings(type: .SEARCH_LOCATION, value: item.type.rawValue)
                    SearchMediator.shared.updateUserList(location: item.type, online: nil)
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }

    private func equals(item: String) -> Bool {
        NSLocalizedString(item, comment: "text").lowercased() == NSLocalizedString(mediator.selectedItem.name, comment: "text").lowercased()
    }
}
