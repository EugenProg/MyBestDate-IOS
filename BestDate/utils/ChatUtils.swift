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
                dateItem = ChatItem(id: item + additionIndex, messageType: type, message: nil, last: false, date: getChatDateFormattedString(date: current.created_at))
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
            if current.image == nil {
                return current.parent_id == nil ? .user_text_message : .user_text_message_with_parent
            } else {
                return current.parent_id == nil ? .user_image_message : .user_image_message_with_parent
            }
        } else {
            if current.image == nil {
                return current.parent_id == nil ? .my_text_message : .my_text_message_with_parent
            } else {
                return current.parent_id == nil ? .my_image_message : .my_image_message_with_parent
            }
        }
    }

    private func isNextDate(firstDate: String?, secondDate: String?) -> Bool {
        firstDate?.getDateString() != secondDate?.getDateString()
    }

    private func getChatDateFormattedString(date: String?) -> String {
        let components = Calendar.current.dateComponents([.day], from: date?.toDate() ?? Date.now, to: Date.now)
        let days = components.day ?? 0

        switch days {
            case 0: return "today".localized()
            case 1: return "yesterday".localized()
            default: return date?.toShortDateString() ?? ""
        }
    }
}
