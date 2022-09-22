//
//  VeggieTrackerAppDelegate.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 21.09.22.
//

import UserNotifications
import SwiftUI

class VeggieTrackerAppDelegate: NSObject, UIApplicationDelegate {
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
      registerForPushNotifications()
      return true
    }

    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
          .requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
          }
    }
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }
    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      print("Failed to register: \(error)")
    }

}
