//
//  RegistrationOtpScreen.swift
//  BestDate
//
//  Created by Евгений on 10.06.2022.
//

import SwiftUI

struct RegistrationOtpScreen: View {
    @EnvironmentObject var store: Store
    @ObservedObject var registrationHolder = RegistrationDataHolder.shared
    
    var body: some View {
        BaseOTPScreen(title: "confirmation_code",
                      description: "on_the_email_you_specified_we_send_the_confirmation_code", email: registrationHolder.email, confirmAction: confirmAction(), resendAction: resendAction())
    }
    
    private func confirmAction() -> (String) -> Void {
        return { code in
            store.dispatch(action: .navigate(screen: .GEO_LOCATION))
        }
    }
    
    private func resendAction() -> () -> Void {
        return {
            store.dispatch(action: .show(message: "resend action"))
        }
    }
}

struct RegistrationOtpScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationOtpScreen()
    }
}
