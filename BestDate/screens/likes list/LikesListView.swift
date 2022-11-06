//
//  LikesListView.swift
//  BestDate
//
//  Created by Евгений on 26.08.2022.
//

import SwiftUI

struct LikesListView: View {
    @ObservedObject var mediator = LikeListMediator.shared

    var clickAction: (ShortUserInfo) -> Void

    var items: [GridItem] = [
        GridItem(.fixed(72), spacing: 3)]

    var body: some View {
        SaveRefreshAndSetPositionScrollView(
            startPosition: mediator.savedPosition,
            offsetChanged: { it in mediator.savePosition(it) },
            onRefresh: { done in mediator.getLikesList { done() } }) {
                if mediator.likeList.isEmpty {
                    NoDataBoxView(loadingMode: $mediator.loadingMode, text: "no_one_has_liked_your_photos_yet")
                        .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
                } else {
                    LazyVGrid(columns: items, alignment: .center, spacing: 10,
                              pinnedViews: [.sectionHeaders, .sectionFooters]) {
                        ForEach(mediator.likeList.indices, id: \.self) { i in
                            LikesListItemView(like: $mediator.likeList[i])
                                .onTapGesture {
                                    withAnimation { clickAction(mediator.likeList[i].user ?? ShortUserInfo()) }
                                }
                        }
                    }.padding(.init(top: 14, leading: 0, bottom: 16, trailing: 0))
                }
            }
            .onAppear {
                if mediator.likeList.isEmpty {
                    mediator.getLikesList { }
                }
            }
    }
}

