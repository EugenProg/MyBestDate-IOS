//
//  ChatActionsBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 31.07.2022.
//

import SwiftUI

struct ChatActionsBottomSheet: View {
    var clickAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Title(textColor: ColorList.white.color, text: "chat_actions", textSize: 28, paddingV: 0, paddingH: 24)
                .padding(.init(top: 0, leading: 0, bottom: 14, trailing: 0))

            ForEach(getActionsList(), id: \.self) { item in
                DarkBottomSheetItem(text: item.rawValue, isSelect: false) { name in
                    ChatMediator.shared.doActionByType(type: item)
                    clickAction()
                }
            }
        }.frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }

    private func getActionsList() -> [ChatActions] {
        if !ChatMediator.shared.isMyMessage() {
            return [.reply, .copy]
        } else if ChatMediator.shared.selectedMessage?.image != nil &&
                    ChatMediator.shared.selectedMessage?.text == nil {
            return [.reply, .delete]
        } else {
            return [.reply, .edit, .copy, .delete]
        }
    }
}

enum ChatActions: String {
    case edit
    case delete
    case reply
    case copy
}
