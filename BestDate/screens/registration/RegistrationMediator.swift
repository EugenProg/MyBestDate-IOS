//
//  RegistrationDataHolder.swift
//  BestDate
//
//  Created by Евгений on 12.06.2022.
//

import Foundation
import UIKit

final class RegistrationMediator: ObservableObject {
    static var shared: RegistrationMediator = RegistrationMediator()
    
    @Published var gender: String = ""
    @Published var login: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var birthDate: Date = Date.getEithteenYearsAgoDate()
    @Published var name: String = ""
    @Published var password: String = ""
    var authType: AuthType = .email

    func sendCode(complete: @escaping (Bool, String) -> Void) {
        if StringUtils.isPhoneNumber(phone: login) {
            authType = .phone
            registrPhone(phone: login) { success, message in complete(success, message) }
        } else if StringUtils.isAEmail(email: login) {
            authType = .email
            registrEmail(email: login) { success, message in complete(success, message) }
        } else {
            complete(false, "enter_email_or_phone".localized())
        }
    }

    private func registrEmail(email: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrEmail(email: email) { success, message in
            DispatchQueue.main.async {
                if success { self.email = email }
            }
            complete(success, message)
        }
    }

    private func registrPhone(phone: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.registrPhone(phone: phone) { success, message in
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
        CoreApiService.shared.confirmPhone(phone: phone, code: code) { success, message in
            if success {
                self.registerByPhone { success, message in complete(success, message) }
            } else { complete(success, message) }
        }
    }

    private func confirmEmail(code: String, complete: @escaping (Bool, String) -> Void) {
        CoreApiService.shared.confirmEmail(email: email, code: code) { success, message in
            if success {
                self.registerByEmail { success, message in complete(success, message) }
            } else { complete(success, message) }
        }
    }

    private func registerByPhone(complete: @escaping (Bool, String) -> Void) {
        let model = RegistrationRequest(phone: phone, name: name, password: password, password_confirmation: password, gender: getGender(), birthday: getBirthDay(), look_for: getAim())

        CoreApiService.shared.registerByPhone(requestModel: model) { success, message in
            if success {
                AuthMediator.shared.loginByPhone(phone: self.phone, password: self.password) { success, message in
                    complete(success, message)
                }
            } else { complete(success, message) }
        }
    }

    private func registerByEmail(complete: @escaping (Bool, String) -> Void) {
        let model = RegistrationRequest(email: email, name: name, password: password, password_confirmation: password, gender: getGender(), birthday: getBirthDay(), look_for: getAim())

        CoreApiService.shared.registerByEmail(requestModel: model) { success, message in
            if success {
                AuthMediator.shared.loginByEmail(email: self.email, password: self.password) { success, message in
                    complete(success, message)
                }
            } else { complete(success, message) }
        }
    }

    func getLogin() -> String {
        authType == .email ? email : phone
    }

    private func getGender() -> String {
        switch gender {
        case "woman_looking_for_a_man".localized(): return "female"
        case "woman_looking_for_a_woman".localized(): return "female"
        case "man_looking_for_a_man".localized(): return "male"
        case "man_looking_for_a_woman".localized(): return "male"
        default: return "male"
        }
    }

    private func getBirthDay() -> String {
        birthDate.toServerDate()
    }

    private func getAim() -> [String] {
        switch gender {
        case "woman_looking_for_a_man".localized(): return ["male"]
        case "woman_looking_for_a_woman".localized(): return ["female"]
        case "man_looking_for_a_man".localized(): return ["male"]
        case "man_looking_for_a_woman".localized(): return ["female"]
        default: return ["male", "female"]
        }
    }

    func setUserData(user: UserInfo) {
        self.name = user.name ?? ""
        self.email = user.email ?? ""
        self.phone = user.phone ?? ""
        self.birthDate = user.birthday?.toDate() ?? Date.getEithteenYearsAgoDate()
        setGender(gender: user.gender ?? "", lookFor: user.look_for ?? [])
    }

    private func setGender(gender: String, lookFor: [String]) {
        if gender == "male" {
            self.gender = lookFor.contains("male") ?
            "man_looking_for_a_man".localized() :
            "man_looking_for_a_woman".localized()
        } else {
            self.gender = lookFor.contains("male") ?
            "woman_looking_for_a_man".localized() :
            "woman_looking_for_a_woman".localized()
        }
    }

    func clearData() {
        self.gender = ""
        self.login = ""
        self.email = ""
        self.phone = ""
        self.birthDate = Date.getEithteenYearsAgoDate()
        self.name = ""
        self.password = ""
    }
}
