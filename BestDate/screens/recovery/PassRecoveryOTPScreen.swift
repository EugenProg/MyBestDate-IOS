//
//  PassRecoveryOTPScreen.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import SwiftUI

struct PassRecoveryOTPScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = RecoveryMediator.shared
    
    @State var process: Bool = false
    
    var body: some View {
        BaseOTPScreen(otpType: .recovery, authType: mediator.authType, login: mediator.getLogin(), confirmAction: confirmAction(), resendAction: resendAction(), process: $process)
    }
    
    private func confirmAction() -> (String) -> Void {
        return { code in
            mediator.code = code
            withAnimation { store.dispatch(action: .navigate(screen: .PASS_RECOVERY_SET_NEW)) }
        }
    }
    
    private func resendAction() -> () -> Void {
        return {
            DispatchQueue.main.async {
                mediator.sendCode { success, message in
                    if !success {
                        store.dispatch(action: .show(message: message))
                    }
                }
            }
        }
    }
}

struct PassRecoveryOTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassRecoveryOTPScreen()
    }
}
