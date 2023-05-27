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
    @ObservedObject var authMediator = AuthMediator.shared
    
    @State var process: Bool = false
    
    var body: some View {
        BaseOTPScreen(otpType: .recovery, authType: mediator.authType, login: mediator.getLogin(), confirmAction: confirmAction(), resendAction: resendAction(), process: $process)
    }
    
    private func confirmAction() -> (String) -> Void {
        return { code in
            process.toggle()
            mediator.confirm(code: code) { success, message in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        goIn(success: success, registrationMode: false, message: message)
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }
            }
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

    private func goIn(success: Bool, registrationMode: Bool, message: String) {
        mediator.clearData()
        store.dispatch(action: .endProcess)
        if success {
            var startScreen: ScreenList = .MAIN
            if !authMediator.hasFullData {
                startScreen = .FILL_REGISTRATION_DATA
            } else if !authMediator.hasImages {
                startScreen = .PROFILE_PHOTO
            } else if !authMediator.hasQuestionnaire {
                startScreen = .QUESTIONNAIRE
            }
            UserDataHolder.shared.setStartScreen(screen: startScreen)
            store.dispatch(action: .navigate(screen: startScreen))
        } else {
            store.dispatch(action: .show(message: message.localized()))
        }
    }
}

struct PassRecoveryOTPScreen_Previews: PreviewProvider {
    static var previews: some View {
        PassRecoveryOTPScreen()
    }
}
