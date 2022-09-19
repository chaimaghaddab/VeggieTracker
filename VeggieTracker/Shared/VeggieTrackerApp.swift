//
//  VeggieTrackerApp.swift
//  Shared
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import UserNotifications

class VeggieAppDelegate: NSObject, UIApplicationDelegate {
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

@main
struct VeggieTrackerApp: App {
    @UIApplicationDelegateAdaptor(VeggieAppDelegate.self) var appDelegate
    @StateObject var model: VeggieTrackerModel = MockModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
