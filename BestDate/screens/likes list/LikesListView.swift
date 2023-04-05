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

    @State var showLoadingBlock: Bool = false

    var items: [GridItem] = [
        GridItem(.fixed(72), spacing: 3)]

    var body: some View {
        SaveRefreshAndSetPositionScrollView(
            startPosition: mediator.savedPosition,
            offsetChanged: { it in mediator.savePosition(it) },
            onRefresh: { done in mediator.getLikesList(withClear: true, page: 0) { done() } }) {
                if mediator.likeList.isEmpty {
                    NoDataBoxView(loadingMode: $mediator.loadingMode, text: "no_one_has_liked_your_photos_yet")
                        .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
                } else {
                    VStack(spacing: 5) {
                        LazyVGrid(columns: items, alignment: .center, spacing: 10,
                                  pinnedViews: [.sectionHeaders, .sectionFooters]) {
                            ForEach(mediator.likeList.indices, id: \.self) { i in
                                LikesListItemView(like: $mediator.likeList[i])
                                    .onTapGesture {
                                        withAnimation { clickAction(mediator.likeList[i].user ?? ShortUserInfo()) }
                                    }
                                    .onAppear {
                                        if (mediator.likeList[i].id ?? 0) == (mediator.likeList.last?.id ?? 0) && !mediator.likeList.isEmpty {
                                            showLoadingBlock = true
                                            mediator.getNextPage()
                                        }
                                    }
                            }
                        }.padding(.init(top: 14, leading: 0, bottom: 16, trailing: 0))

                        if (mediator.meta.current_page ?? 0) < (mediator.meta.last_page ?? 0) && showLoadingBlock {
                            LoadingNextPageView()
                        }
                    }
                }
            }
            .onAppear {
                if mediator.likeList.isEmpty {
                    mediator.getLikesList(withClear: true, page: 0) { }
                }
            }
    }
}

