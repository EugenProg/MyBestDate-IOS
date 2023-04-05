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
    @Published var meta: Meta = Meta()
    var savedPosition: CGFloat = 0

    func getLikesList(withClear: Bool, page: Int, completion: @escaping () -> Void) {
        loadingMode = true
        MatchesApiService.shared.getUserLikes(page: page) { success, likes, meta in
            DispatchQueue.main.async {
                withAnimation {
                    self.likeList.addAll(list: likes, clear: withClear)
                    self.meta = meta
                    completion()
                    self.loadingMode = false
                }
            }
        }
    }

    func getNextPage() {
        if (meta.current_page ?? 0) >= (meta.last_page ?? 0) { return }

        getLikesList(withClear: false, page: (meta.current_page ?? 0) + 1) { }
    }

    func savePosition(_ offset: CGFloat) {
        savedPosition = -((offset / 72) * 2)
    }

    func clearData() {
        likeList.removeAll()
    }
}
