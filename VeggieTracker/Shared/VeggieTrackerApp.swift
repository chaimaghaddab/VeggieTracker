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
//    VeggieTrackerModel(user: User(username: "Nathalie"), children: [Child](), meals: [Meal](), notifications: [Notification]())
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
