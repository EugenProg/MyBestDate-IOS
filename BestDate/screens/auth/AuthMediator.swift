//
//  AuthMediator.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class AuthMediator: ObservableObject {
    static let shared = AuthMediator()

    func auth(login: String, password: String, complete: @escaping (Bool, String) -> Void) {
        if StringUtils.isPhoneNumber(phone: login) {
            loginByPhone(phone: login, password: password) { success in complete(success, "wrong_auth_data") }
        } else if StringUtils.isAEmail(email: login) {
            loginByEmail(email: login, password: password) { success in complete(success, "wrong_auth_data") }
        } else {
            complete(false, "enter_email_or_phone")
        }
    }

    func loginByPhone(phone: String, password: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.loginByPhone(phone: phone, password: password) { _ in
                self.getUserData() { success in
            complete(success)
            }
        }
    }

    func loginByEmail(email: String, password: String, complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.loginByEmail(userName: email, password: password) { _ in
            self.getUserData() { success in
                complete(success)
            }
        }
    }

    private func getUserData(complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.getUserData { success, user in
            DispatchQueue.main.async {
                if success {
                    PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                    RegistrationMediator.shared.setUserData(user: user)
                    MainMediator.shared.setUserInfo(user: user)
                    QuestionnaireMediator.shared.setQuestionnaire(questionnaire: user.questionnaire ?? Questionnaire())
                    QuestionnaireMediator.shared.setUserLocation(location: user.location ?? Location())
                }
                complete(success)
            }

        }
    }
}
