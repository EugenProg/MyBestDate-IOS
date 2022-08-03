//
//  MessageListView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct MessageListView: View {
    @Binding var messageList: [ChatItem]
    var clickAction: (ChatItem) -> Void

    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 5)]

    var body: some View {
        LazyVGrid(columns: items, alignment: .center, spacing: 6, pinnedViews: [.sectionHeaders, .sectionFooters]) {
            ForEach(messageList, id: \.id) { item in
                getMessageViewByType(item: item)
                    .rotationEffect(Angle(degrees: 180))
                    .onTapGesture {
                        if item.messageType != .date_block {
                            clickAction(item)
                        }
                    }
            }
        }
    }

    private func getMessageViewByType(item: ChatItem) -> some View {
        Group {
            switch item.messageType {
            case .my_text_message: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_text_message_with_parent: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_voice_message: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_voice_message_with_parent: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_image_message: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_image_message_with_parent: MyTextMessageView(message: item.message, isLast: item.last)
            case .user_text_message: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .user_text_message_with_parent: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .user_voice_message: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .user_voice_message_with_parent: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .user_image_message: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .user_image_message_with_parent: CompanionTextMessageView(message: item.message, isLast: item.last)
            case .date_block: DateBlockView(date: item.date ?? "")
            }
        }
    }
}
