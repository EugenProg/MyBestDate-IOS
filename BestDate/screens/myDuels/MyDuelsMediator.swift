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

    func getMyDuels() {
        TopApiService.shared.getMyDuelsList { success, list in
            DispatchQueue.main.async {
                self.duelList.clearAndAddAll(list: list)
            }
        }
    }
}
