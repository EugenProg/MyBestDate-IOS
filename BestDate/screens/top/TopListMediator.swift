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
    @Published var manListMeta: Meta = Meta()
    @Published var womanListMeta: Meta = Meta()

    var manSavedPosition: CGFloat = 0
    var womanSavedPosition: CGFloat = 0

    func getManList(withClear: Bool, page: Int) {
        manLoadingMode = withClear
        TopApiService.shared.getTopList(gender: .man, page: page) { success, list, meta in
            DispatchQueue.main.async {
                if success {
                    self.manTopList.addAll(list: list, clear: withClear)
                    self.manListMeta = meta ?? Meta()
                }
                self.manLoadingMode = false
            }
        }
    }

    func getWomanList(withClear: Bool, page: Int) {
        womanLoadingMode = withClear
        TopApiService.shared.getTopList(gender: .woman, page: page) { success, list, meta in
            DispatchQueue.main.async {
                if success {
                    self.womanTopList.addAll(list: list, clear: withClear)
                    self.womanListMeta = meta ?? Meta()
                }
                self.womanLoadingMode = false
            }
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

    func getManNextPage() {
        if (manListMeta.current_page ?? 0) >= (manListMeta.last_page ?? 0) { return }

        getManList(withClear: false, page: (manListMeta.current_page ?? 0) + 1)
    }

    func getWomanNextPage() {
        if (womanListMeta.current_page ?? 0) >= (womanListMeta.last_page ?? 0) { return }

        getWomanList(withClear: false, page: (womanListMeta.current_page ?? 0) + 1)
    }
}
