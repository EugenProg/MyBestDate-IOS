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
        SaveAndSetPositionScrollView(
            startPosition: mediator.savedPosition,
            offsetChanged: { it in mediator.savePosition(it) },
            onRefresh: { done in mediator.getLikesList { done() } }) {
                if mediator.likeList.isEmpty {
                    let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
                    NoDataView(loadingMode: $mediator.loadingMode)
                        .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
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

