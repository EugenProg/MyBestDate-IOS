//
//  RecoveryDataHolder.swift
//  BestDate
//
//  Created by Евгений on 13.06.2022.
//

import Foundation

class RecoveryMediator: ObservableObject {
    static var shared: RecoveryMediator = RecoveryMediator()

    @Published var login: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var newPass: String = ""
    var code: String = ""

    func sendCode(complete: @escaping (Bool, String) -> Void) {
        if StringUtils.isPhoneNumber(phone: login) {
            resetPhone(phone: login) { success in complete(success, "default_error_message".localized()) }
        } else if StringUtils.isAEmail(email: login) {
            resetEmail(email: login) { success in complete(success, "default_error_message".localized()) }
        } else {
            complete(false, "enter_email_or_phone")
        }
    }

    private func resetEmail(email: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.resetEmail(email: email) { success in
            DispatchQueue.main.async {
                if success { self.email = email }
            }
            complete(success)
        }
    }

    private func resetPhone(phone: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.resetPhone(phone: phone) { success in
            DispatchQueue.main.async {
                if success { self.phone = phone }
            }
            complete(success)
        }
    }

    func confirm(complete: @escaping (Bool, String) -> Void) {
        if email.isEmpty {
            confirmPhone(code: code) { success in
                complete(success, "default_error_message".localized())
            }
        } else if phone.isEmpty {
            confirmEmail(code: code) { success in
                complete(success, "default_error_message".localized())
            }
        } else {
            complete(false, "default_error_message".localized())
        }
    }

    private func confirmPhone(code: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.confirmPhoneReset(phone: phone, code: code, password: newPass) { success in
            if success {
                CoreApiService.shared.loginByPhone(phone: self.phone, password: self.newPass) { success in complete(success) }
            } else { complete(false) }
        }
    }

    private func confirmEmail(code: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.confirmEmailReset(email: email, code: code, password: newPass) { success in
            if success {
                CoreApiService.shared.loginByEmail(userName: self.email, password: self.newPass) { success in complete(success) }
            } else { complete(false) }
        }
    }
}
