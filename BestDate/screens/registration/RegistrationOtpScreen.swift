//
//  RegistrationOtpScreen.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct RegistrationOtpScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = RegistrationMediator.shared

    @State var process: Bool = false
    
    var body: some View {
        BaseOTPScreen(title: "confirmation_code",
                      description: "on_the_email_you_specified_we_send_the_confirmation_code", email: mediator.email, confirmAction: confirmAction(), resendAction: resendAction(), process: $process)
    }
    
    private func confirmAction() -> (String) -> Void {
        return { code in
            process.toggle()
            mediator.confirm(code: code) { success, message in
                DispatchQueue.main.async {
                    process.toggle()
                    if success {
                        UserDataHolder.setStartScreen(screen: .GEO_LOCATION)
                        withAnimation { store.dispatch(action: .navigate(screen: .GEO_LOCATION)) }
                    } else {
                        store.dispatch(action: .show(message: message))
                    }
                }

            }
        }
    }
    
    private func resendAction() -> () -> Void {
        return {
            process.toggle()
            mediator.sendCode { success, message in
                DispatchQueue.main.async {
                    process.toggle()
                    if !success {
                        store.dispatch(action: .show(message: message))
                    }
                }

            }
        }
    }
}

struct RegistrationOtpScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationOtpScreen()
    }
}
