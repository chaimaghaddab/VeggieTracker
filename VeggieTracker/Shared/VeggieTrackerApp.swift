//
//  VeggieTrackerApp.swift
//  Shared
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import UserNotifications

@main
struct VeggieTrackerApp: App {
    @StateObject var model: VeggieTrackerModel = MockModel()
    @State private var alert = false
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model).onAppear(){
                UNUserNotificationCenter.current()
                    .requestAuthorization(
                        options: [.alert, .sound, .badge]) { success, _ in
                            print("Permission granted: \(success)")
                            guard success else { return }
                            DispatchQueue.main.async {
                                UIApplication.shared.registerForRemoteNotifications()
                            }
                        }
            }
        }
    }
}
