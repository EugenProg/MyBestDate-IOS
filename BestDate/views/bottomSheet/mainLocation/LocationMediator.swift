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
        itemList.append(LocationTypesListItem(id: 0, name: "next_to_me", type: .nearby))
        itemList.append(LocationTypesListItem(id: 1, name: "all_world", type: .all))
        itemList.append(LocationTypesListItem(id: 2, name: MainMediator.shared.user.location?.country ?? "", type: .country))
        itemList.append(LocationTypesListItem(id: 3, name: MainMediator.shared.user.location?.city ?? "", type: .city))

        selectedItem = itemList.first(where: { item in
            item.type == UserDataHolder.searchLocation
        }) ?? itemList[1]
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
}
