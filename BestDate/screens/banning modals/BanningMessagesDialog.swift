//
//  BanningMessagesModal.swift
//  BestDate
//
//  Created by Евгений on 26.02.2023.
//

import SwiftUI

struct BanningMessagesDialog: View {
    @EnvironmentObject var store: Store

    var body: some View {
        BunningModalView(
            background: LinearGradient(colors: [
                MyColor.getColor(45, 54, 59),
                MyColor.getColor(46, 50, 67)
            ], startPoint: .top, endPoint: .bottom),
            headerImage: "ic_banning_message",
            title: "messages",
            description: "you_have_three_messages_per_day",
            color: ColorList.pink.color) {
                store.state.showMessageBunningDialog = false
            } activateAction: {
                store.state.showMessageBunningDialog = false
            }
    }
}
