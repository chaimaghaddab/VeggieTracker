//
//  VeggieTrackerApp.swift
//  Shared
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI


@main
struct VeggieTrackerApp: App {
    @StateObject var model: VeggieTrackerModel = MockModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
