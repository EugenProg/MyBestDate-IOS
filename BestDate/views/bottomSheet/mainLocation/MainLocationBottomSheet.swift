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
                    UserDataHolder.setSearchLocation(filter: item.type)
                    SearchMediator.shared.updateUserList(location: item.type, online: nil)
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
            .onAppear {
                mediator.updateItemsList()
            }
    }

    private func equals(item: String) -> Bool {
        item.localized().lowercased() == mediator.selectedItem.name.localized().lowercased()
    }
}
