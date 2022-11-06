//
//  SocialNetworkBottomSheet.swift
//  BestDate
//
//  Created by Евгений on 23.09.2022.
//

import SwiftUI
import AuthenticationServices

struct SocialNetworkBottomSheet: View {
    @EnvironmentObject var store: Store
    @ObservedObject var mediator = SocialNetworkMediator.shared

    var clickAction: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            SignInWithAppleButton(.signIn) { request in
                store.dispatch(action: .startProcess)
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                mediator.signInWithApple(result: result) { success, message in
                    DispatchQueue.main.async {
                        store.dispatch(action: .endProcess)
                        if !success {
                            store.dispatch(action: .show(message: message))
                        }
                    }
                }
            }.signInWithAppleButtonStyle(.white)
                .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                .cornerRadius(32)

        }
    }
}
