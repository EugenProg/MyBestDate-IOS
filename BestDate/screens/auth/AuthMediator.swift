//
//  AuthMediator.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation

class AuthMediator: ObservableObject {
    static let shared = AuthMediator()

    var hasImages: Bool = false
    var hasQuestionnaire: Bool = false
    var hasFullData: Bool = true

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

    func getUserData(complete: @escaping (Bool) -> Void) {
        CoreApiService.shared.updateLanguage(lang: "lang_code".localized()) { success, user in
            DispatchQueue.main.async {
                if success {
                    self.hasImages = user.photos?.isEmpty == false
                    self.hasQuestionnaire = user.questionnaire?.isEmpty() == false
                    self.hasFullData = user.name?.isEmpty == false &&
                                        user.gender?.isEmpty == false &&
                                        user.look_for?.isEmpty == false &&
                                        user.birthday?.isEmpty == false

                    if !self.hasFullData {
                        FillRegistrationDataMediator.shared.setUserData(user: user)
                    } else if self.hasImages && self.hasQuestionnaire {
                        MainMediator.shared.setUserInfo(user: user)
                    } else {
                        PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                        RegistrationMediator.shared.setUserData(user: user)
                        QuestionnaireMediator.shared.setEditInfo(user: user, editMode: false)
                    }
                    CoreApiService.shared.storeDeviceToken(token: UserDataHolder.notificationToken)
                }
                complete(success)
            }
        }
    }
}

