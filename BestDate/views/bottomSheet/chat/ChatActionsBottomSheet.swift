//
//  ChatActionsBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 31.07.2022.
//

import SwiftUI

struct ChatActionsBottomSheet: View {
    var clickAction: () -> Void

    let myItems: [ChatActions] = [
        .edit,
        .delete,
        .reply
    ]

    let userItems: [ChatActions] = [
        .reply
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "Chat actions", textSize: 32, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(ChatMediator.shared.isMyMessage() ? myItems.indices : userItems.indices, id: \.self) { index in
                let item = ChatMediator.shared.isMyMessage() ? myItems[index] : userItems[index]
                DarkBottomSheetItem(text: item.rawValue, isSelect: false) { name in
                    ChatMediator.shared.doActionByType(type: item)
                    clickAction()
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }
}

enum ChatActions: String {
    case edit
    case delete
    case reply
}
