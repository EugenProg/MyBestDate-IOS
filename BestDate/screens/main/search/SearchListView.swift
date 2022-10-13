//
//  SearchListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct SearchListView: View {
    @Binding var list: [ShortUserInfo?]
    @Binding var meta: Meta
    @Binding var loadingMode: Bool
    var clickAction: (ShortUserInfo) -> Void
    var loadNextPage: () -> Void

    @State var showLoadingBlock: Bool = false

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]

    var body: some View {
        if list.isEmpty {
            NoDataBoxView(loadingMode: $loadingMode, text: "nothing_was_found_by_these_parameters")
                .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
        } else {
            LazyVGrid(columns: items, alignment: .center, spacing: 10,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list.indices, id: \.self) { i in
                    let user = list[i]
                    UserSearchItemView(user: $list[i])
                        .onTapGesture {
                            withAnimation { clickAction(user ?? ShortUserInfo()) }
                        }
                        .onAppear {
                            if (user?.id ?? 0) == (list.last??.id ?? 0) && !list.isEmpty {
                                showLoadingBlock = true
                            }
                        }
                }
            }

            if (meta.current_page ?? 0) < (meta.last_page ?? 0) && showLoadingBlock {
                LoadingNextPageView()
                    .onAppear {
                        loadNextPage()
                    }
            }
        }
    }
}

