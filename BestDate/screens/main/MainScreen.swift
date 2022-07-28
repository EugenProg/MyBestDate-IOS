//
//  MainScreen.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = MainMediator.shared
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                SearchScreen()

                MatchesScreen()

                ChatListScreen()

                DuelScreen()

                GuestsScreen()
            }.offset(x: mediator.currentScreen.offset, y: 0)

            VStack {
                Spacer()
                BottomMainNavigationView(currentScreen: $mediator.currentScreen, hasNewMessages: $mediator.hasNewMessages, hasNewGuests: $mediator.hasNewGuests) { type in
                    mediator.currentScreen = type
                    if type == .TOP_50 && !DuelMediator.shared.hasADuelAction {
                        DuelMediator.shared.getVotePhotos { _ in }
                    }
                }
            }
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }
}
