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

                TopScreen()

                GuestsScreen()
            }.offset(x: mediator.currentScreen.offset, y: 0)

            VStack {
                Spacer()
                BottomMainNavigationView(currentScreen: $mediator.currentScreen, hasNewMessages: $mediator.hasNewMessages, hasNewGuests: $mediator.hasNewGuests) { type in
                    mediator.currentScreen = type
                }
            }
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))
            }
    }
}