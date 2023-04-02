//
//  SearchMediator.swift
//  BestDate
//
//  Created by Евгений on 10.07.2022.
//

import Foundation
import SwiftUI

class SearchMediator: ObservableObject {
    static let shared = SearchMediator()

    private let itemHeight: CGFloat = ((UIScreen.main.bounds.width - 9) / 2) + 54

    @Published var users: [ShortUserInfo?] = []
    @Published var meta: Meta = Meta()
    @Published var loadingMode: Bool = true

    var searchFilter: Filter? = nil
    var searchCity: CityListItem? = nil
    var selectedGender: FilterGender? = nil
    var savedPosition: CGFloat = 0

    var locationType: LocationFilterTypes = UserDataHolder.searchLocation
    var onlineType: OnlineFilterTypes = UserDataHolder.searchOnline

    func getUserList(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        loadingMode = withClear
        self.savedPosition = 0
        CoreApiService.shared.getUsersList(location: locationType, online: onlineType, filter: searchFilter, genderFilter: selectedGender ?? .all_gender, page: page) { success, userList, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.users.addAll(list: userList, clear: withClear)
                    self.meta = meta
                }
                self.loadingMode = false
                completion()
            }
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getUserList(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    func updateUserList(location: LocationFilterTypes?, online: OnlineFilterTypes?) {
        if location != nil && location != locationType {
            searchFilter = nil
            locationType = location ?? .all
            if onlineType == .filter { OnlineMediator.shared.setSelectedItem(type: OnlineFilterTypes.all) }
            getUserList(withClear: true, page: 0) { }
        } else if online != nil && online != onlineType {
            searchFilter = nil
            onlineType = online ?? .all
            if locationType == .filter { LocationMediator.shared.setSelectedItem(type: LocationFilterTypes.all) }
            getUserList(withClear: true, page: 0) { }
        }
    }

    func setSearchFilter(address: CityListItem, range: Int) {
        GeocodingApiService().getLocationByAddress(address: address) { response in
            DispatchQueue.main.async {
                LocationMediator.shared.setSelectedItem(type: .filter)
                self.locationType = .filter
                OnlineMediator.shared.setSelectedItem(type: .filter)
                self.onlineType = .filter
                self.searchCity = address
                self.searchFilter = response.getSearchFilter(range: range)
                self.getUserList(withClear: true, page: 0) { }
            }
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / itemHeight) * 2)
    }

    func clearData() {
        users.removeAll()
    }

    func setSearchGender(searchGender: FilterGender) {
        if self.selectedGender == nil {
            self.selectedGender = searchGender
        }
    }

    func setGender(gender: FilterGender) {
        self.selectedGender = gender
        self.getUserList(withClear: true, page: 0) { }
    }
}
