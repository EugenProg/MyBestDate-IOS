//
//  BunningInvitationsDialog.swift
//  BestDate
//
//  Created by Евгений on 26.02.2023.
//

import SwiftUI

struct BunningInvitationsDialog: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        BunningModalView(
            background: LinearGradient(colors: [
                MyColor.getColor(45, 54, 59),
                MyColor.getColor(44, 60, 65)
            ], startPoint: .top, endPoint: .bottom),
            headerImage: "ic_bunning_card",
            title: "inviations",
            description: "you_have_one_card_per_day",
            color: ColorList.light_blue.color) {
                store.state.showInvitationBunningDialog = false
            } activateAction: {
                store.state.showInvitationBunningDialog = false
                store.dispatch(action: .navigate(screen: .TARIFF_LIST))
            }
    }
}
