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

    func getGuests(completion: @escaping () -> Void) {
        CoreApiService.shared.getGuests { success, guests in
            DispatchQueue.main.async {
                if success {
                    self.setGuests(guests: guests)
                }
            }
            completion()
        }
    }

    private func setGuests(guests: [Guest]) {
        self.oldGuests.removeAll()
        self.newGuests.removeAll()
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
            CoreApiService.shared.setGuestViewed(ids: ids) { success in
            }
        }
    }

    func clearGuestData() {
        newGuests.removeAll()
        oldGuests.removeAll()
    }
}
