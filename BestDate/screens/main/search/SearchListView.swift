//
//  SearchListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct SearchListView: View {
    @Binding var list: [ShortUserInfo]
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
            let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
            NoDataView(loadingMode: $loadingMode)
                .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
        } else {
            LazyVGrid(columns: items, alignment: .center, spacing: 10,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list.indices, id: \.self) { i in
                    let user = list[i]
                    UserSearchItemView(user: user)
                        .onTapGesture {
                            withAnimation { clickAction(user) }
                        }
                        .onAppear {
                            if user.id == list.last?.id {
                                showLoadingBlock = true
                            }
                        }
                }
            }

            if (meta.current_page ?? 0) < (meta.last_page ?? 0) && showLoadingBlock && !list.isEmpty {
                LoadingNextPageView()
                    .onAppear {
                        loadNextPage()
                    }
            }
        }
    }
}

