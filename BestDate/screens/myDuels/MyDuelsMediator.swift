//
//  MyDuelsMediator.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import Foundation

class MyDuelsMediator: ObservableObject {
    static var shared = MyDuelsMediator()

    @Published var duelList: [MyDuel] = []
    @Published var loadingMode: Bool = true
    @Published var meta: Meta = Meta()

    func getMyDuels(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        loadingMode = true
        TopApiService.shared.getMyDuelsList(page: page) { success, list, meta in
            DispatchQueue.main.async {
                self.duelList.addAll(list: list, clear: withClear)
                self.meta = meta
                self.loadingMode = false
                completion()
            }
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getMyDuels(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    func clearData() {
        duelList.removeAll()
    }
}
