//
//  MessageListView.swift
//  BestDate
//
//  Created by Евгений on 30.07.2022.
//

import SwiftUI

struct MessageListView: View {
    @Binding var messageList: [ChatItem]
    @Binding var meta: Meta
    var clickAction: (ChatItem) -> Void

    var imageClick: (ChatImage?) -> Void
    var loadNextPage: () -> Void

    var translateClick: (Message?) -> Void

    @State var showLoadingBlock: Bool = false

    var items: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width), spacing: 5)]

    var body: some View {
        VStack(spacing: 5) {
            LazyVGrid(columns: items, alignment: .center, spacing: 6, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach($messageList, id: \.id) { item in
                    getMessageViewByType(item: item)
                        .rotationEffect(Angle(degrees: 180))
                        .onTapGesture {
                            if item.wrappedValue.messageType != .date_block {
                                clickAction(item.wrappedValue)
                            }
                        }
                        .onAppear {
                            if item.wrappedValue.id == (messageList.last?.id ?? 0) && !messageList.isEmpty {
                                showLoadingBlock = true
                                loadNextPage()
                            }
                        }
                }
            }

            if (meta.current_page ?? 0) < (meta.last_page ?? 0) && showLoadingBlock {
                LoadingDotsView()
            }
        }
    }

    private func getMessageViewByType(item: Binding<ChatItem>) -> some View {
        let parentMessage = getMessageById(id: item.wrappedValue.message?.parent_id)
        let topOffset = parentMessage.wrappedValue?.text?.getLinesHeight(viewVidth: UIScreen.main.bounds.width - 80, fontSize: 17).height ?? (parentMessage.wrappedValue?.image != nil ? 35 : 21)
        let bottomOffset = item.wrappedValue.message?.text?.getLinesHeight(viewVidth: UIScreen.main.bounds.width - 92, fontSize: 17).height ?? 21
        return Group {
            switch item.wrappedValue.messageType {
            case .my_text_message: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_text_message_with_parent: MyTextMessageWithParentView(message: item.message, isLast: item.last, parentMessage: parentMessage, topOffset: topOffset, bottomOffset: bottomOffset)
            case .my_voice_message: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_voice_message_with_parent: MyTextMessageView(message: item.message, isLast: item.last)
            case .my_image_message: MyImageMessageView(message: item.message, isLast: item.last, selectClick: {
                clickAction(item.wrappedValue) }) { image in imageClick(image) }
            case .my_image_message_with_parent: MyTextMessageWithParentView(message: item.message, isLast: item.last, parentMessage: parentMessage, topOffset: topOffset, bottomOffset: bottomOffset)
            case .user_text_message: CompanionTextMessageView(message: item.message, isLast: item.last,
                                    translateClick: { m in translateClick(m) })
            case .user_text_message_with_parent: CompanionTextMessageWithParentView(message: item.message, isLast: item.last, parentMessage: parentMessage, topOffset: topOffset, bottomOffset: bottomOffset, translateClick: { m in translateClick(m) })
            case .user_voice_message: CompanionTextMessageView(message: item.message, isLast: item.last,
                                                               translateClick: { m in translateClick(m) })
            case .user_voice_message_with_parent: CompanionTextMessageView(message: item.message, isLast: item.last,
                                                                           translateClick: { m in translateClick(m) })
            case .user_image_message: CompanionImageMessageView(message: item.message, isLast: item.last, selectClick: { clickAction(item.wrappedValue) },
                imageClick: { image in imageClick(image) }, translateClick: { m in translateClick(m) })
            case .user_image_message_with_parent: CompanionTextMessageWithParentView(message: item.message, isLast: item.last, parentMessage: parentMessage, topOffset: topOffset, bottomOffset: bottomOffset, translateClick: { m in translateClick(m) })
            case .date_block: DateBlockView(date: item.date)
            }
        }
    }


    func getMessageById(id: Int?) -> Binding<Message?> {
        for index in $messageList.wrappedValue.indices {
            if $messageList.wrappedValue[index].message?.id == id {
                return $messageList[index].message
            }
        }
        return $messageList.first!.message
    }
}
