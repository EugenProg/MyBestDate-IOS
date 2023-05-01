//
//  MainOnlineBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import SwiftUI

struct MainOnlineBottomSheet: View {
    @ObservedObject var mediator = OnlineMediator.shared

    var clickAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "online", textSize: 28, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(mediator.itemList, id: \.id) { item in
                DarkBottomSheetItem(text: item.name, isSelect: equals(item: item.name)) { name in
                    clickAction()
                    mediator.selectedItem = item
                    UserDataHolder.shared.setSearchOnline(filter: item.type)
                    SearchMediator.shared.updateUserList(location: nil, online: item.type)
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }

    private func equals(item: String) -> Bool {
        item.localized().lowercased() == mediator.selectedItem.name.localized().lowercased()
    }
}
