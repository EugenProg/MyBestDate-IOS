//
//  MyDuelsListView.swift
//  BestDate
//
//  Created by Евгений on 23.07.2022.
//

import SwiftUI

struct MyDuelsListView: View {
    var list: [MyDuel]
    @Binding var loadingMode: Bool

    var items: [GridItem] = [
            GridItem(.fixed(UIScreen.main.bounds.width), spacing: 10)]

    var body: some View {
        if list.isEmpty && !loadingMode {
            let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
            NoDataBoxView(loadingMode: $loadingMode, text: "nobody_voted_for_you_yet")
                .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
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

