//
//  TopListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopListView: View {
    @Binding var list: [Top]
    @Binding var loadingMode: Bool
    @Binding var savedPosition: CGFloat
    var offsetChanged: (CGFloat) -> Void
    var clickAction: (ShortUserInfo) -> Void

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]

    var body: some View {
        SaveAndSetPositionScrollView(startPosition: savedPosition,
                                     offsetChanged: { offsetChanged($0) }) {
            if loadingMode && list.isEmpty {
                ProgressView()
                    .tint(ColorList.white.color)
                    .frame(width: 80, height: 80)
            } else {
                LazyVGrid(columns: items, alignment: .center, spacing: 3,
                          pinnedViews: [.sectionHeaders, .sectionFooters]) {
                    ForEach(list.indices, id: \.self) { index in
                        let top = list[index]
                        TopListItemView(item: top, place: index + 1)
                            .onTapGesture {
                                withAnimation { clickAction(top.user ?? ShortUserInfo()) }
                            }
                    }
                }
            }
        }
    }
}
