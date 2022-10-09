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
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }

        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: presentingViewController) { user, error in
            if let error = error {
                print(">>> error: \(error.localizedDescription)")
            }

            print(">>> SUCCESS\nname = \(user?.profile?.name ?? "")\nemail = \(user?.profile?.email ?? "")\ntoken = \(user?.authentication.accessToken ?? "")")

            CoreApiService.shared.signInWithSocial(provider: .google, token: user?.authentication.accessToken ?? "") { success, registrationMode in complete(success, registrationMode)
            }
        }
    }

    func signInWithFacebook(complete: @escaping (Bool, Bool) -> Void) {
        let loginManager = LoginManager()

        loginManager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
            print(">>> ready")
            GraphRequest(graphPath: "me", parameters: ["fields": "email, first_name, last_name, gender, picture"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    let fbDetails = result as! NSDictionary
                    print(fbDetails)
                }
            })
//            switch request {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
//                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
//                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
//                    if (error == nil) {
//                        let fbDetails = result as! NSDictionary
//                        print(fbDetails)
//                    }
//                })
//            }
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
