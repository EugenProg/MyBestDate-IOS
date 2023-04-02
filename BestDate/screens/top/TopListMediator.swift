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

    private let itemHeight: CGFloat = ((UIScreen.main.bounds.width - 9) / 2) + 20

    @Published var activePage: GenderType = .woman

    @Published var womanTopList: [Top] = []
    @Published var manTopList: [Top] = []
    @Published var manLoadingMode: Bool = true
    @Published var womanLoadingMode: Bool = true

    var manSavedPosition: CGFloat = 0
    var womanSavedPosition: CGFloat = 0

    func getManList() {
        manLoadingMode = true
        TopApiService.shared.getTopList(gender: .man) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.manTopList.clearAndAddAll(list: list)
                }
                self.manLoadingMode = false
            }
        }
    }

    func getWomanList() {
        womanLoadingMode = true
        TopApiService.shared.getTopList(gender: .woman) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.womanTopList.clearAndAddAll(list: list)
                }
                self.womanLoadingMode = false
            }
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

    func savePosition(_ offset: CGFloat) {
        if activePage == .man { manSavedPosition = -((offset / itemHeight) * 2) }
        else { womanSavedPosition = -((offset / itemHeight) * 2) }
    }
}
