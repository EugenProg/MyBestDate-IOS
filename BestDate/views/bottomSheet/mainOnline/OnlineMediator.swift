//
//  OnlineMediator.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import Foundation

class OnlineMediator: ObservableObject {
    static var shared = OnlineMediator()

    @Published var selectedItem: OnlineTypesListItem = OnlineTypesListItem(id: 0, name: "", type: .all)
    @Published var itemList: [OnlineTypesListItem] = []

    init() {
        itemList.append(OnlineTypesListItem(id: 0, name: "online", type: .online))
        itemList.append(OnlineTypesListItem(id: 1, name: "not_selected", type: .all))
        itemList.append(OnlineTypesListItem(id: 2, name:  "was_recently", type: .recently))

        selectedItem = itemList.first(where: { item in
            item.type == UserDataHolder.shared.getSearchOnlineFilter()
        }) ?? itemList[1]
    }

    func setSelectedItem(type: OnlineFilterTypes) {
        self.selectedItem = OnlineTypesListItem(id: 0, name: type.name, type: type)
    }
}

struct OnlineTypesListItem {
    var id: Int
    var name: String
    var type: OnlineFilterTypes
}

enum OnlineFilterTypes: String {
    case all
    case online
    case recently
    case filter

    var name: String {
        switch self {
        case .all: return "all"
        case .online: return "online"
        case .recently: return "recently"
        case .filter: return "filter"
        }
    }
}
