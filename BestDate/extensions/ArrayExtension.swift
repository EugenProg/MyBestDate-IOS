//
//  ArrayExtension.swift
//  BestDate
//
//  Created by Евгений on 25.08.2022.
//

import Foundation

extension Array where Element == String {
    func equals(array: [String]?) -> Bool {
        if self.count != array?.count { return false }
        for item in self {
            if !(array?.contains(item) ?? false) { return false }
        }

        return true
    }

    func toString() -> String {
        if self.isEmpty { return "" }
        var result = ""
        for item in self {
            result += "\(item), "
        }
        if !result.isEmpty {
            return String(result.prefix(result.count - 2))
        }

        return result
    }
}

extension Array where Element == ProfileImage {
    mutating func clearAndAddAll(list: [ProfileImage]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == ShortUserInfo {
    mutating func addAll(list: [ShortUserInfo]?, clear: Bool) {
        if clear { self.removeAll() }

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == Top {
    mutating func clearAndAddAll(list: [Top]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == Invitation {
    mutating func clearAndAddAll(list: [Invitation]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == InvitationCard {
    mutating func clearAndAddAll(list: [InvitationCard]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == MyDuel {
    mutating func clearAndAddAll(list: [MyDuel]?) {
        self.removeAll()

        for item in list ?? [] {
            self.append(item)
        }
    }
}

extension Array where Element == ChatItem {
    mutating func addAll(list: [Message], clear: Bool? = nil) {
        if clear == true {
            self.removeAll()
        }

        let items = ChatUtils().getChatItemsFromMessages(messageList: list)
        for item in items {
            self.append(item)
        }
    }

    mutating func add(message: Message) {
        var messages: [Message] = []

        messages.append(message)

        for item in self {
            if item.messageType != .date_block {
                messages.append(item.message ?? Message())
            }
        }

        var newItemList: [ChatItem] = []
        newItemList.addAll(list: messages)

        self = newItemList
    }

    mutating func update(message: Message) {
        var messages: [Message] = []

        for item in self {
            if item.messageType != .date_block {
                messages.append(item.message ?? Message())
            }
        }

        let updateIndex = messages.firstIndex { item in
            item.id == (message.id ?? 0)
        }
        messages[updateIndex ?? 0] = message

        var newItemList: [ChatItem] = []
        newItemList.addAll(list: messages)

        self = newItemList
    }

    mutating func delete(id: Int?) {
        var messages: [Message] = []

        let deletedIndex = self.firstIndex { item in
            item.message?.id == id
        }
        self.remove(at: deletedIndex ?? 0)

        for item in self {
            if item.messageType != .date_block {
                messages.append(item.message ?? Message())
            }
        }

        var newItemList: [ChatItem] = []
        newItemList.addAll(list: messages)

        self = newItemList
    }
}
