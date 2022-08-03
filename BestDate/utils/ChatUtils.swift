//
//  ChatUtils.swift
//  BestDate
//
//  Created by Евгений on 31.07.2022.
//

import Foundation

class ChatUtils {

    func getChatItemsFromMessages(messageList: [Message]) -> [ChatItem] {
        var listItems: [ChatItem] = []
        var additionIndex = 0

        for item in messageList.indices {
            let current = messageList[item]
            let previous = item == (messageList.endIndex - 1) ? nil : messageList[item + 1]
            let next = item > 0 ? messageList[item - 1] : nil
            var dateItem: ChatItem? = nil

            var type = getMessageType(current: current, previous: previous, withDate: true)

            if type == .date_block {
                dateItem = ChatItem(id: item + additionIndex, messageType: type, message: nil, last: false, date: current.created_at?.toShortDateString())
                additionIndex += 1
                type = getMessageType(current: current, previous: previous, withDate: false)
            }

            listItems.append(
                ChatItem(
                    id: item + additionIndex,
                    messageType: type,
                    message: messageList[item],
                    last: current.sender_id != next?.sender_id || (isNextDate(firstDate: current.created_at, secondDate: next?.created_at)),
                    date: nil
                )
            )

            if dateItem != nil {
                listItems.append(dateItem ?? ChatItem(id: 0, messageType: .date_block, last: false))
            }
        }
        
        return listItems
    }

    private func getMessageType(current: Message, previous: Message?, withDate: Bool) -> ChatViewType {
        if withDate && isNextDate(firstDate: current.created_at, secondDate: previous?.created_at) {
            return .date_block
        }

        if current.sender_id != MainMediator.shared.user.id {
            return .user_text_message
        } else {
            return .my_text_message
        }
    }

    private func isNextDate(firstDate: String?, secondDate: String?) -> Bool {
        firstDate?.getDateString() != secondDate?.getDateString()
    }
}
