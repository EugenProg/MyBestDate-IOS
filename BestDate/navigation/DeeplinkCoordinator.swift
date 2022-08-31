//
//  DeeplinkCoordinator.swift
//  BestDate
//
//  Created by Евгений on 29.08.2022.
//

import Foundation
import SwiftUI

protocol DeeplinkHandlerProtocol {
    func canOpenURL(_ url: URL) -> Bool
    func openURL(_ url: URL)
}

protocol DeeplinkCoordinatorProtocol {
    @discardableResult
    func handleURL(_ url: URL) -> Bool
}

final class DeeplinkCoordinator {

    let handlers: [DeeplinkHandlerProtocol]

    init(handlers: [DeeplinkHandlerProtocol]) {
        self.handlers = handlers
    }
}

extension DeeplinkCoordinator: DeeplinkCoordinatorProtocol {

    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }

        handler.openURL(url)
        return true
    }
}

final class UserProfileDeeplinkHandler: DeeplinkHandlerProtocol {
    private weak var store: Store?
        init(store: Store) {
            self.store = store
        }

    func canOpenURL(_ url: URL) -> Bool {
        return url.absoluteString.contains("best-date://user/")
    }

    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }

        let userId = url.absoluteString.suffix(url.absoluteString.count - 17)

        CoreApiService.shared.getUsersById(id: String(userId).toInt()) { success, user in
            DispatchQueue.main.async {
                withAnimation {
                    if success {
                        AnotherProfileMediator.shared.setUser(user: user)
                        if self.store?.state.activeScreen == .START {
                            self.store?.dispatch(action: .hasADeepLink)
                        } else {
                            self.store?.dispatch(action: .navigate(screen: .ANOTHER_PROFILE))
                        }
                    } else {
                        self.store?.dispatch(action:
                                .show(message: NSLocalizedString("default_error_message", comment: "Error"))
                        )
                    }
                }
            }
        }
    }
}
