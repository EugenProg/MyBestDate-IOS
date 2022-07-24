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

    func getManList() {
        TopApiService.shared.getTopList(gender: .man) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.manTopList.clearAndAddAll(list: list)
                }
            }
        }
    }

    func getWomanList() {
        TopApiService.shared.getTopList(gender: .woman) { success, list in
            DispatchQueue.main.async {
                if success {
                    self.manTopList.clearAndAddAll(list: list)
                }
            }
        }
    }
}
