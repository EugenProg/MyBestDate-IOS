//
//  TopListView.swift
//  BestDate
//
//  Created by Евгений on 22.07.2022.
//

import SwiftUI

struct TopListView: View {
    @Binding var page: GenderType
    @Binding var womanList: [Top]
    @Binding var manList: [Top]
    var clickAction: (ShortUserInfo) -> Void

    var items: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3),
        GridItem(.fixed((UIScreen.main.bounds.width - 9) / 2), spacing: 3)]

    fileprivate func listView(list: [Top]) -> some View {
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

    var body: some View {
        if page == .man {
            listView(list: manList).transition(.move(edge: .trailing))
        } else {
            listView(list: womanList)
        }
    }
}
