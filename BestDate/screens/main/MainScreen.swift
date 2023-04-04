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
            Group {
                switch mediator.currentScreen {
                case .SEARCH: SearchScreen()
                case .MATCHES: MatchesScreen()
                case .CHAT_LIST: ChatListScreen()
                case .TOP_50: DuelScreen()
                case .GUESTS: GuestsScreen()
                }
            }

            VStack {
                Spacer()
                BottomMainNavigationView(currentScreen: $mediator.currentScreen, hasNewMessages: $mediator.hasNewMessages, hasNewGuests: $mediator.hasNewGuests) { type in
                    mediator.currentScreen = type
                    mediator.selectAction(type: type)
                }
            }
        }.background(ColorList.main.color.edgesIgnoringSafeArea(.bottom))
            .onAppear {
                store.dispatch(action:
                        .setScreenColors(status: ColorList.main.color, style: .lightContent))

                if ChatListMediator.shared.newChats.isEmpty &&
                    ChatListMediator.shared.previousChats.isEmpty {
                    ChatListMediator.shared.getChatList(withClear: true, page: 0)
                }

                if store.state.hasADeepLink {
                    withAnimation {
                        store.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                        store.state.hasADeepLink = false
                    }
                }
            }
    }
}
