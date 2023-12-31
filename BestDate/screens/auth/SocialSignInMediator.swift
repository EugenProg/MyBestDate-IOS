//
//  SocialSignInMediator.swift
//  BestDate
//
//  Created by Евгений on 29.09.2022.
//

import Foundation
import AuthenticationServices
import GoogleSignIn
import FBSDKLoginKit

class SocialSignInMediator: NSObject, ObservableObject {
    static let shared = SocialSignInMediator()

    var appleSignAppAction: ((Bool, Bool) -> Void)? = nil

    func loginSocial(provider: SocialOAuthType, completion: @escaping (Bool, Bool) -> Void) {
        switch provider {
        case .google: signInWithGoogle(complete: completion)
        case .apple: signInWithApple(complete: completion)
        case .facebook: signInWithFacebook(complete: completion)
        }
    }

    func signInWithApple(complete: @escaping (Bool, Bool) -> Void) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self

        controller.performRequests()
    }

    func signInWithGoogle(complete: @escaping (Bool, Bool) -> Void) {
        let signInConfig = GIDConfiguration(clientID: "320734338059-5llkt240p9ev4v67dngnbehj4lnki47b.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = signInConfig
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { auth, error in
            if let error = error {
                print(">>> error: \(error.localizedDescription)")
            }
            let user = auth?.user

            print(">>> SUCCESS\nname = \(user?.profile?.name ?? "")\nemail = \(user?.profile?.email ?? "")\ntoken = \(user?.accessToken.tokenString ?? "")")

            if !(user?.accessToken.tokenString ?? "").isEmpty {
                CoreApiService.shared.signInWithSocial(provider: .google, token: user?.accessToken.tokenString ?? "") { success, registrationMode in complete(success, registrationMode)
                }
            }
        }
    }

    func signInWithFacebook(complete: @escaping (Bool, Bool) -> Void) {
        let loginManager = LoginManager()

        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { loginResult, error  in
            if loginResult?.isCancelled == false {
                GraphRequest(graphPath: "me", parameters: ["fields": "email, first_name, last_name, gender, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil) {
                        CoreApiService.shared.signInWithSocial(provider: .facebook, token: loginResult?.token?.tokenString ?? "") { success, registrationMode in complete(success, registrationMode)
                        }
                    }
                })
            }
        }
    }
}

extension SocialSignInMediator: ASAuthorizationControllerDelegate {
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
                let token = appleIdCredential.identityToken != nil ? String(decoding: appleIdCredential.identityToken!, as: UTF8.self) : ""
                CoreApiService.shared.signInWithSocial(provider: .apple, token: token) { success, mode in
                    if self.appleSignAppAction != nil { self.appleSignAppAction!(success, mode) }
                }
                break

            case let passwordCredential as ASPasswordCredential:
                print("\n ** ASPasswordCredential ** \n")
                print(passwordCredential.user)  // This is a user identifier
                print(passwordCredential.password) //The password
                break

            default:
                print("asdf")
                break
            }
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
            print(error)
        }
}

enum SocialOAuthType: String {
    case google
    case apple
    case facebook
}
