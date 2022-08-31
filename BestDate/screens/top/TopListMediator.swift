//
//  TopListMediator.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import Foundation
import SwiftUI

class TopListMediator: ObservableObject {
    static var shared = TopListMediator()

    @Published var activePage: GenderType = .woman

    @Published var womanTopList: [Top] = []
    @Published var manTopList: [Top] = []
    @Published var loadingMode: Bool = true

    func getManList() {
        loadingMode = true
        TopApiService.shared.getTopList(gender: .man) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.manTopList.clearAndAddAll(list: list)
                }
                self.loadingMode = false
            }
        }
    }

    func getWomanList() {
        loadingMode = true
        TopApiService.shared.getTopList(gender: .woman) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.womanTopList.clearAndAddAll(list: list)
                }
                self.loadingMode = false
            }
        }
    }

    func updateActiveList() {
        if activePage == .man {
            getManList()
        } else {
            getWomanList()
        }
    }

    func updateChangedList(isManUpdate: Bool, isWomanUpdate: Bool) {
        if isManUpdate {
            getManList()
        }
        if isWomanUpdate {
            getWomanList()
        }
    }

    func clearTopList() {
        manTopList.removeAll()
        womanTopList.removeAll()
    }
}
