//
//  ChatListView.swift
//  BestDate
//
//  Created by Евгений on 24.07.2022.
//

import SwiftUI

struct ChatListView: View {
    @Binding var newList: [Chat]
    @Binding var previousList: [Chat]
    @Binding var deleteProcess: Bool

    var deleteAction: (Chat) -> Void
    var clickAction: (Chat) -> Void
    
    var items: [GridItem] = [
            GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    fileprivate func chatListBlock(header: String, list: Binding<[Chat]>, itemsType: ChatItemType) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(NSLocalizedString(header, comment: "Header").uppercased())
                .foregroundColor(ColorList.white_40.color)
                .font(MyFont.getFont(.NORMAL, 18))
                .padding(.init(top: 30, leading: 18, bottom: 10, trailing: 18))

            LazyVGrid(columns: items, alignment: .center, spacing: 6, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list, id: \.id) { chat in
                    ChatListItemView(item: chat, type: itemsType, deleteProccess: $deleteProcess) { chat in
                        deleteAction(chat)
                    } clickAction: { chat in
                        clickAction(chat)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if newList.isEmpty && previousList.isEmpty {
                let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
                NoDataView()
                    .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
            } else {
                if !newList.isEmpty {
                    chatListBlock(header: "new_message", list: $newList, itemsType: .new)
                }
                if !previousList.isEmpty {
                    chatListBlock(header: "all_message", list: $previousList, itemsType: .old)
                }
            }
        }
    }
}
