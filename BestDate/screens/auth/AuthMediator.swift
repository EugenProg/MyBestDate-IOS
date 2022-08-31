//
//  AuthMediator.swift
//  BestDate
//
//  Created by Евгений on 05.07.2022.
//

import Foundation
import AuthenticationServices

class AuthMediator: ObservableObject {
    static let shared = AuthMediator()

    var hasImages: Bool = false
    var hasQuestionnaire: Bool = false

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
                    self.hasImages = !(user.photos?.isEmpty ?? true)
                    self.hasQuestionnaire = !(user.questionnaire?.isEmpty() ?? true)

                    if self.hasImages && self.hasQuestionnaire {
                        MainMediator.shared.setUserInfo(user: user)
                    } else {
                        PhotoEditorMediator.shared.setImages(images: user.photos ?? [])
                        RegistrationMediator.shared.setUserData(user: user)
                        QuestionnaireMediator.shared.setEditInfo(user: user, editMode: false)
                    }
                }
                complete(success)
            }
        }
    }

    func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = SignInWithAppleDelegates { success in

        }

        controller.performRequests()
    }
}

class SignInWithAppleDelegates: NSObject, ASAuthorizationControllerDelegate {
    var isSignIn: (Bool) -> Void

    init(_ action: @escaping (Bool) -> Void) {
        self.isSignIn = action
    }

    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            print("\n ** ASAuthorizationAppleIDCredential - \(#function)** \n")
            print(appleIdCredential.email ?? "Email not available.")
            print(appleIdCredential.fullName ?? "fullname not available")
            print(appleIdCredential.fullName?.givenName ?? "givenName not available")
            print(appleIdCredential.fullName?.familyName ?? "Familyname not available")
            print(appleIdCredential.user)  // This is a user identifier
            print(appleIdCredential.identityToken?.base64EncodedString() ?? "Identity token not available") //JWT Token
            print(appleIdCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
            break

        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            print(passwordCredential.user)  // This is a user identifier
            print(passwordCredential.password) //The password
            break

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
    }
}


