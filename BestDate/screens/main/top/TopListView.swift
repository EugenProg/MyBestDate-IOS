//
//  TopListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopListView: View {
    @Binding var list: [Top]
    var clickAction: (ShortUserInfo) -> Void

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]

    var body: some View {
        if list.isEmpty {
            let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
            NoDataView()
                .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
        } else {
            LazyVGrid(columns: items, alignment: .center, spacing: 3,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list, id: \.id) { top in
                    TopListItemView(item: top)
                        .onTapGesture {
                            withAnimation { clickAction(top.user ?? ShortUserInfo()) }
                        }
                }
            }
        }
    }
}
