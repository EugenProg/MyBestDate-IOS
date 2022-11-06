//
//  AppDelegate.swift
//  BestDate
//
//  Created by Евгений on 29.08.2022.
//

import Foundation
import SwiftUI
import Firebase
import UserNotifications
import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"
    var store: Store? = nil

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

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

      //  ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        application.registerForRemoteNotifications()
        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

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
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        UserDataHolder.setNotificationToken(token: fcmToken)
        print("Device token: ", fcmToken ?? "") // This token can be used for testing notifications on FCM
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
            if pushType == .defaultPush {
                PushMediator.shared.setDefaultMessage(body: notification.request.content.body, title: notification.request.content.title)
            } else {
                PushMediator.shared.setUser(jsonString: userInfo["user"] as? String ?? "")
            }
            store?.dispatch(action: .showPushNotification(type: pushType))
        } else {
            let pushType = NotificationType.getNotificationType(type: userInfo["type"] as? String ?? "")
            if pushType != .defaultPush {
                AnotherProfileMediator.shared.setUser(jsonString: userInfo["user"] as? String ?? "")
                store?.dispatch(action: .hasADeepLink)
            }
            completionHandler([[.banner, .badge, .sound]])
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID from userNotificationCenter didReceive: \(messageID) 4321")
        }

        print(userInfo)

        completionHandler()
    }
}
