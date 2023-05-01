//
//  LocationMediator.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import Foundation

class LocationMediator: ObservableObject {
    static var shared = LocationMediator()

    @Published var selectedItem: LocationTypesListItem = LocationTypesListItem(id: 0, name: "", type: .all)
    @Published var itemList: [LocationTypesListItem] = []

    init() {
        updateItemsList()
    }

    func updateItemsList() {
        itemList.removeAll()
        itemList.append(LocationTypesListItem(id: 0, name: "next_to_me", type: .nearby))
        itemList.append(LocationTypesListItem(id: 1, name: "all_world", type: .all))
        itemList.append(LocationTypesListItem(id: 2, name: MainMediator.shared.user.location?.country ?? "", type: .country))
        itemList.append(LocationTypesListItem(id: 3, name: MainMediator.shared.user.location?.city ?? "", type: .city))

        if selectedItem.type != .filter {
            selectedItem = itemList.first(where: { item in
                item.type == UserDataHolder.shared.getSearchLocationFilter()
            }) ?? itemList[1]
        }
    }

    func setSelectedItem(type: LocationFilterTypes) {
        self.selectedItem = LocationTypesListItem(id: 0, name: type.name, type: type)
    }
}

struct LocationTypesListItem {
    var id: Int
    var name: String
    var type: LocationFilterTypes
}

enum LocationFilterTypes: String {
    case all
    case nearby
    case country
    case city
    case filter

    var name: String {
        switch self {
        case .all: return "all_world".localized()
        case .nearby: return "next_to_me".localized()
        case .country: return MainMediator.shared.user.location?.country ?? ""
        case .city: return MainMediator.shared.user.location?.city ?? ""
        case .filter: return "Filter"
        }
    }
}
