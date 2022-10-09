//
//  SocialNetworkMediator.swift
//  BestDate
//
//  Created by Евгений on 23.09.2022.
//

import Foundation
import AuthenticationServices

class SocialNetworkMediator: ObservableObject {
    static var shared = SocialNetworkMediator()

    func signInWithApple(result: Result<ASAuthorization, Error>, completion: @escaping (Bool, String) -> Void) {
        switch result {
            case .success(let authorization):
                //Handle autorization
                if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                    let userId = appleIDCredential.user
                    let identityToken = appleIDCredential.identityToken
                    let authCode = appleIDCredential.authorizationCode
                    let email = appleIDCredential.email
                    let givenName = appleIDCredential.fullName?.givenName
                    let familyName = appleIDCredential.fullName?.familyName
                    let state = appleIDCredential.state

                    print("id \(userId)\n")
                    print("token \(identityToken)\n")
                    print("auth code \(authCode)\n")
                    print("email \(email)\n")
                    print("name \(givenName)\n")
                    print("familie \(familyName)\n")
                    print("state \(state)\n")
                    // Here you have to send the data to the backend and according to the response let the user get into the app.
                    completion(true, "")
                }

                break
            case .failure(let error):
            completion(false, error.localizedDescription)
                break
            }
    }
}
