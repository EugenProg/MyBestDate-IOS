//
//  ChatListView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatListView: View {
    @Binding var newList: [ChatListItem]
    @Binding var previousList: [ChatListItem]
    @Binding var deleteProcess: Bool
    @Binding var loadingMode: Bool

    var deleteAction: (Chat) -> Void
    var clickAction: (Chat) -> Void
    
    var items: [GridItem] = [
            GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    fileprivate func chatListBlock(header: String, list: Binding<[ChatListItem]>, itemsType: ChatItemType) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(header.localized().uppercased())
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 18))
                .padding(.init(top: 30, leading: 18, bottom: 10, trailing: 18))

            LazyVGrid(columns: items, alignment: .center, spacing: 6, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list, id: \.id) { item in
                    if item.chat.user.wrappedValue?.getRole() == .user {
                        ChatListItemView(item: item.chat, typingMode: item.typingMode, isOnline: item.isOnline, type: itemsType, deleteProccess: $deleteProcess) { chat in
                            deleteAction(chat)
                        } clickAction: { chat in
                            clickAction(chat)
                        }
                    } else {
                        ChatBotItemView(item: item.chat, type: itemsType) { chat in
                            clickAction(chat)
                        }
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if !newList.isEmpty {
                chatListBlock(header: "new_message", list: $newList, itemsType: .new)
            }
            if !previousList.isEmpty {
                chatListBlock(header: "all_message", list: $previousList, itemsType: .old)
            }
        }
    }
}
