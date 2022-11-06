//
//  MatchesListView.swift
//  BestDate
//
//  Created by Евгений on 27.08.2022.
//

import SwiftUI

struct MatchesListView: View {
    @ObservedObject var mediator = MatchesListMediator.shared

    var userSelectAction: (ShortUserInfo) -> Void
    var showMatchAction: (Match) -> Void

    var items: [GridItem] = [
        GridItem(.fixed(99), spacing: 3)]
    
    var body: some View {
        SaveRefreshAndSetPositionScrollView(
            startPosition: mediator.savedPosition,
            offsetChanged: { it in mediator.savePosition(it) },
            onRefresh: { done in mediator.getMatchesList { done() } }) {
                if mediator.matches.isEmpty {
                    NoDataBoxView(loadingMode: $mediator.loadingMode, text: "you_dont_have_a_match_yet")
                        .padding(.init(top: 50, leading: 50, bottom: ((UIScreen.main.bounds.width - 9) / 2) - 69, trailing: 50))
                } else {
                    LazyVGrid(columns: items, alignment: .center, spacing: 20,
                              pinnedViews: [.sectionHeaders, .sectionFooters]) {
                        ForEach(mediator.matches.indices, id: \.self) { i in
                            MatchesListItemView(
                                match: $mediator.matches[i],
                                myPhoto: $mediator.myPhoto,
                                userSelectAction: userSelectAction,
                                showMatchAction: showMatchAction
                            )
                        }
                    }.padding(.init(top: 14, leading: 0, bottom: 16, trailing: 0))
                }
            }
            .onAppear {
                if mediator.matches.isEmpty {
                    mediator.getMatchesList { }
                }
            }
    }
}
