//
//  LikeListMediator.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import Foundation
import SwiftUI

class LikeListMediator: ObservableObject {
    static var shared = LikeListMediator()

    @Published var likeList: [Like] = []
    @Published var loadingMode: Bool = true
    var savedPosition: CGFloat = 0

    func getLikesList(completion: @escaping () -> Void) {
        loadingMode = true
        MatchesApiService.shared.getUserLikes { success, likes in
            DispatchQueue.main.async {
                withAnimation {
                    self.likeList.clearAndAddAll(list: likes)
                    completion()
                    self.loadingMode = false
                }
            }
        }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / 72) * 2)
    }

    func clearData() {
        likeList.removeAll()
    }
}
