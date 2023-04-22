//
//  TopListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopListView: View {
    @Binding var list: [Top]
    @Binding var meta: Meta
    @Binding var loadingMode: Bool
    @Binding var savedPosition: CGFloat
    var offsetChanged: (CGFloat) -> Void
    var clickAction: (ShortUserInfo) -> Void
    var loadNextPage: () -> Void

    @State var showLoadingBlock: Bool = false

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]

    var body: some View {
        SaveAndSetPositionScrollView(startPosition: savedPosition,
                                     offsetChanged: { offsetChanged($0) }) {
            if loadingMode {
                LoadingView()
                    .padding(.top, 50)
            } else {
                VStack {
                    LazyVGrid(columns: items, alignment: .center, spacing: 3,
                              pinnedViews: [.sectionHeaders, .sectionFooters]) {
                        ForEach(list.indices, id: \.self) { index in
                            let top = list[index]
                            TopListItemView(item: top, place: index + 1)
                                .onTapGesture {
                                    withAnimation { clickAction(top.user ?? ShortUserInfo()) }
                                }
                                .onAppear {
                                    if top.id == (list.last?.id ?? 0) && !list.isEmpty {
                                        showLoadingBlock = true
                                        loadNextPage()
                                    }
                                }
                        }
                    }
                    
                    if (meta.current_page ?? 0) < (meta.last_page ?? 0) && showLoadingBlock {
                        LoadingNextPageView()
                    }
                }
            }
        }
    }
}
