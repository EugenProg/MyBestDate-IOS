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
    var authType: AuthType = .email

    func sendCode(complete: @escaping (Bool, String) -> Void) {
        if StringUtils.isPhoneNumber(phone: login) {
            authType = .phone
            resetPhone(phone: login) { success, message in complete(success, message) }
        } else if StringUtils.isAEmail(email: login) {
            authType = .email
            resetEmail(email: login) { success, message in complete(success, message) }
        } else {
            complete(false, "enter_email_or_phone".localized())
        }
    }

    private func resetEmail(email: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.resetEmail(email: email) { success, message in
            DispatchQueue.main.async {
                if success { self.email = email }
            }
            complete(success, message)
        }
    }

    private func resetPhone(phone: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.resetPhone(phone: phone) { success, message in
            DispatchQueue.main.async {
                if success { self.phone = phone }
            }
            complete(success, message)
        }
    }

    func confirm(code: String, complete: @escaping (Bool, String) -> Void) {
        if email.isEmpty {
            confirmPhone(code: code) { success, message in
                complete(success, message)
            }
        } else if phone.isEmpty {
            confirmEmail(code: code) { success, message in
                complete(success, message)
            }
        } else {
            complete(false, "default_error_message".localized())
        }
    }

    private func confirmPhone(code: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmPhoneReset(phone: phone, code: code, password: newPass) { success, message in
            if success {
                AuthMediator.shared.loginByPhone(phone: self.phone, password: self.newPass) { success, message in
                    complete(success, message)
                }
            } else { complete(success, message) }
        }
    }

    private func confirmEmail(code: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmEmailReset(email: email, code: code, password: newPass) { success, message in
            if success {
                AuthMediator.shared.loginByEmail(email: self.email, password: self.newPass) { success, message in
                    complete(success, message)
                }
            } else { complete(success, message) }
        }
    }

    func getLogin() -> String {
        authType == .email ? email : phone
    }

    func clearData() {
        self.login = ""
        self.email = ""
        self.phone = ""
        self.newPass = ""
    }
}
