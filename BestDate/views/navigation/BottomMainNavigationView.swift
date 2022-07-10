//
//  BottomMainNavigationView.swift
//  BestDate
//
//  Created by Евгений on 07.07.2022.
//

import SwiftUI

struct BottomMainNavigationView: View {
    @EnvironmentObject var store: Store

    @Binding var currentScreen: MainScreensType
    @Binding var hasNewMessages: Bool
    @Binding var hasNewGuests: Bool

    var clickAction: (MainScreensType) -> Void
    @State private var emptyAction: Bool = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(ColorList.main.color)
                .cornerRadius(radius: 33, corners: [.topLeft, .topRight])
                .shadow(color: MyColor.getColor(17, 24, 28, 0.63), radius: 46, y: -7)

            HStack(alignment: .top, spacing: 0) {
                let spaceDistance = (UIScreen.main.bounds.width - 300) / 6
                let halfDistance = spaceDistance / 2

                BottomMainNavigationItemView(text: "search", activeIcon: "ic_menu_search_active", unActiveIcon: "ic_menu_search_unactive", type: .SEARCH, currentScreen: $currentScreen, hasNewActions: $emptyAction) { type in clickAction(type) }
                    .padding(.init(top: 0, leading: spaceDistance, bottom: 0, trailing: halfDistance))

                BottomMainNavigationItemView(text: "matches", activeIcon: "ic_menu_match_active", unActiveIcon: "ic_menu_match_unactive", type: .MATCHES, currentScreen: $currentScreen, hasNewActions: $emptyAction) { type in clickAction(type) }
                    .padding(.init(top: 0, leading: halfDistance, bottom: 0, trailing: halfDistance))

                BottomMainNavigationItemView(text: "messages", activeIcon: "ic_menu_message_active", unActiveIcon: "ic_menu_message_unactive", type: .CHAT_LIST, currentScreen: $currentScreen, hasNewActions: $hasNewMessages) { type in clickAction(type) }
                    .padding(.init(top: 0, leading: halfDistance, bottom: 0, trailing: halfDistance))

                BottomMainNavigationItemView(text: "top_50", activeIcon: "ic_menu_top_active", unActiveIcon: "ic_menu_top_unactive", type: .TOP_50, currentScreen: $currentScreen, hasNewActions: $emptyAction) { type in clickAction(type) }
                    .padding(.init(top: 0, leading: halfDistance, bottom: 0, trailing: halfDistance))

                BottomMainNavigationItemView(text: "guests", activeIcon: "ic_menu_guests_active", unActiveIcon: "ic_menu_guests_unactive", type: .GUESTS, currentScreen: $currentScreen, hasNewActions: $hasNewGuests) { type in clickAction(type) }
                    .padding(.init(top: 0, leading: halfDistance, bottom: 0, trailing: spaceDistance))
            }.frame(height: store.state.statusBarHeight + 86, alignment: .top)
                .padding(.init(top: 18, leading: 0, bottom: 0, trailing: 0))
        }.frame(width: UIScreen.main.bounds.width, height: store.state.statusBarHeight + 86)
    }
}
