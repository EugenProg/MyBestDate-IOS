//
//  AppDelegate.swift
//  BestDate
//
//  Created by Евгений on 29.08.2022.
//

import Foundation
import SwiftUI
import FirebaseCore
import Firebase
import FirebaseDynamicLinks
import UserNotifications
import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    var store: Store? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })

            let testNotificationCategory =
            UNNotificationCategory(identifier: "notificationCategories", actions: [], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([testNotificationCategory])
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }

        Messaging.messaging().delegate = self

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(">>> remote")
      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }

//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        ApplicationDelegate.shared.application(
//            app, open: url,
//            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//
//            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
//        )
//    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      let handled = DynamicLinks.dynamicLinks()
        .handleUniversalLink(userActivity.webpageURL!) { dynamiclink, error in
          // ...
        }

      return handled
    }

    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
      return application(app, open: url,
                         sourceApplication: options[UIApplication.OpenURLOptionsKey
                           .sourceApplication] as? String,
                         annotation: "")
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                     annotation: Any) -> Bool {

        if DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) != nil {
            store?.dispatch(action: .startProcess)

            let userId = url.absoluteString.suffix(url.absoluteString.count - 21)
            if String(userId).toInt() > 0 {
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
                                        .show(message: "default_error_message".localized())
                                )
                            }
                        }
                    }
                }
            }

            return true
        }
        return false
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        Messaging.messaging().token { token, error in
            if let error = error {
                print("FCM regiatration error \(error)")
            } else if let token = token {
                UserDataHolder.shared.setNotificationToken(token: token)
                print("Device token: ", token)
            }
        }
         // This token can be used for testing notifications on FCM
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        if UIApplication.shared.applicationState == .active {
            let pushType = NotificationType.getNotificationType(type: userInfo["type"] as? String ?? "")
            PushMediator.shared.setUser(user: (userInfo["user"] as? String ?? "").getUserFromJson())
            if !(pushType == .message && self.isInChatOrChatList(userInfo: userInfo)) {
                if pushType == .message {
                    MainMediator.shared.hasNewMessages = true
                } else if pushType == .guest {
                    MainMediator.shared.hasNewGuests = true
                } else {
                    store?.dispatch(action: .showPushNotification(type: pushType))
                }
            }
        } else {
            let pushType = NotificationType.getNotificationType(type: userInfo["type"] as? String ?? "")
            if pushType != .defaultPush {
                AnotherProfileMediator.shared.setUser(jsonString: userInfo["user"] as? String ?? "")
                store?.dispatch(action: .hasADeepLink)
            }
            completionHandler([[.banner, .badge, .sound]])
        }
        ProfileMediator.shared.updateUserData { }
    }

    func isInChatOrChatList(userInfo: [AnyHashable : Any]) -> Bool {
        let user = (userInfo["user"] as? String ?? "").getUserFromJson()
        return (store?.state.activeScreen == .MAIN &&
                MainMediator.shared.currentScreen == .CHAT_LIST) ||
        (store?.state.activeScreen == .CHAT && user?.id == ChatMediator.shared.user?.id ?? 0)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(">>> error \(error)")
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        let pushType = NotificationType.getNotificationType(type: userInfo["type"] as? String ?? "")
        var screen: ScreenList = store?.state.activeScreen ?? .MAIN
        switch pushType {
        case .like: screen = .LIKES_LIST
        case .match: screen = .MATCHES_LIST
        case .invitation: do {
            InvitationMediator.shared.activeType = .new
            screen = .INVITATION
        }
        case .invitation_answer: do {
            InvitationMediator.shared.activeType = .sended
            screen = .INVITATION
        }
        case .message: do {
            ChatMediator.shared.setUser(user: (userInfo["user"] as? String ?? "").getUserFromJson() ?? ShortUserInfo())
            screen = .CHAT
        }
        case .guest: do {
            GuestsMediator.shared.getGuests(withClear: true, page: 0) { }
            MainMediator.shared.currentScreen = .GUESTS
            screen = .MAIN
        }
        case .moderation_failure: do {
            screen = .PROFILE
            ImagePickerMediator.shared.isShowingPhotoLibrary = true
        }
        case .moderation_success: screen = .PROFILE
        case .defaultPush:
            screen = store?.state.activeScreen ?? .MAIN
        }

        if screen != store?.state.activeScreen ?? .MAIN {
            store?.dispatch(action: .navigate(screen: screen))
        }

        completionHandler()
    }
}
