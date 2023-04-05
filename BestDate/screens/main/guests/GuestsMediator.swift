//
//  GuestsMediator.swift
//  BestDate
//
//  Created by Евгений on 18.07.2022.
//

import Foundation

class GuestsMediator: ObservableObject {
    static var shared = GuestsMediator()

    @Published var newGuests: [Guest] = []
    @Published var oldGuests: [Guest] = []
    @Published var loadingMode: Bool = true
    @Published var lastGuestId: Int = 0
    @Published var meta: Meta = Meta()

    func getGuests(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        loadingMode = true
        CoreApiService.shared.getGuests(page: page) { success, guests, meta in
            DispatchQueue.main.async {
                if success {
                    self.lastGuestId = guests.last?.id ?? 0
                    self.setGuests(withClear: withClear, guests: guests)
                    self.meta = meta
                }
                self.loadingMode = false
            }
            completion()
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getGuests(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    private func setGuests(withClear: Bool, guests: [Guest]) {
        if withClear { self.oldGuests.removeAll() }
        if withClear { self.newGuests.removeAll() }
        for guest in guests {
            if !(guest.viewed ?? false) {
                self.newGuests.append(guest)
            } else {
                self.oldGuests.append(guest)
            }
        }
        setGuestViewed()
    }

    private func setGuestViewed() {
        var ids: [Int] = []
        for guest in newGuests {
            ids.append(guest.id ?? 0)
        }
        if !ids.isEmpty {
            CoreApiService.shared.setGuestViewed(ids: ids) { success in }
        }
    }

    func clearGuestData() {
        newGuests.removeAll()
        oldGuests.removeAll()
    }
}
