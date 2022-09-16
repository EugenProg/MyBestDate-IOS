//
//  BlackListView.swift
//  BestDate
//
//  Created by Евгений on 15.09.2022.
//

import SwiftUI

struct BlackListView: View {
    @ObservedObject var mediator = BlackListMedialtor.shared

    var items: [GridItem] = [
        GridItem(.fixed(72), spacing: 3)]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
                if mediator.list.isEmpty {
                    let topPadding = ((UIScreen.main.bounds.height - 260) / 2) - 100
                    NoDataView(loadingMode: $mediator.loadingMode)
                        .padding(.init(top: topPadding, leading: 0, bottom: 0, trailing: 0))
                } else {
                    LazyVGrid(columns: items, alignment: .center, spacing: 10,
                              pinnedViews: [.sectionHeaders, .sectionFooters]) {
                        ForEach(mediator.list.indices, id: \.self) { i in
                            BlackListItemView(user: $mediator.list[i]) { id in
                                mediator.unlockProfile(userId: id)
                            }
                        }
                    }.padding(.init(top: 14, leading: 0, bottom: 16, trailing: 0))
                }
            }
    }
}
