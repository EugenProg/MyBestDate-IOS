//
//  PassRecoveryOTPScreen.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import SwiftUI

struct PassRecoveryOTPScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var recoveryHolder = RecoveryDataHolder.shared
    
    var body: some View {
        BaseOTPScreen(title: "code_send_to_your_email", description: "confirmation_code_sent_to_email_address", email: recoveryHolder.email, confirmAction: confirmAction(), resendAction: resendAction())
    }
    
    private func confirmAction() -> (String) -> Void {
        return { code in
            store.dispatch(action: .navigate(screen: .PASS_RECOVERY_SET_NEW))
        }
    }
    
    private func resendAction() -> () -> Void {
        return {
            store.dispatch(action: .show(message: "resend action"))
        }
    }
}

struct PassRecoveryOTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassRecoveryOTPScreen()
    }
}
