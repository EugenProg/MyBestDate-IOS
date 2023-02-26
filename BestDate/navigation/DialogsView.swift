//
//  DialogsView.swift
//  BestDate
//
//  Created by Евгений on 26.02.2023.
//

import SwiftUI

struct DialogsView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        ZStack {
            if store.state.showBottomSheet { BaseBottomSheet().zIndex(1) }
            else if store.state.showMessage { AlertScreen().zIndex(1) }
            else if store.state.showInvitationDialog { CreateInvitionScreen().zIndex(1) }
            else if store.state.showMatchActionDialog { MatchActionScreen().zIndex(1) }
            else if store.state.showPushNotification { PushScreen().zIndex(1) }
            else if store.state.showDeleteDialog { DeleteUserDialog().zIndex(1) }
            else if store.state.showLanguageSettingDialog { LanguageSettingsDialog().zIndex(1) }
            else if store.state.showSetPermissionDialog { PermissionDialog().zIndex(1) }
            else if store.state.inProcess { LoadingProgressScreen().zIndex(1) }
            else if store.state.showMessageBunningDialog { BanningMessagesDialog().zIndex(1) }
            else if store.state.showInvitationBunningDialog { BunningInvitationsDialog().zIndex(1) }
        }
    }
}

struct DialogsView_Previews: PreviewProvider {
    static var previews: some View {
        DialogsView()
    }
}
