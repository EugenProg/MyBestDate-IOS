//
//  MyDuelsListView.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct MyDuelsListView: View {
    var list: [MyDuel]

    var items: [GridItem] = [
            GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    var body: some View {
        if list.isEmpty {
            let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
            NoDataView()
                .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
        } else {
            LazyVGrid(columns: items, alignment: .center, spacing: 10,
                      pinnedViews: [.sectionHeaders, .sectionFooters]) {
                ForEach(list, id: \.id) { duel in
                    MyDuelsListItemView(item: duel)
                }
            }
        }
    }
}

