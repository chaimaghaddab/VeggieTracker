//
//  ContentView.swift
//  Shared
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import os
import UserNotifications

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var model: VeggieTrackerModel
    @State private var isShowingChildrenView = false
    @State private var isShowingInfoView = false
    @State private var isShowingCookbook = false
    @State private var scheduleNotifications = false
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "ContentView")
    
    var body: some View {
        NavigationView  {
            VStack {
                Text("Hello, \(model.user.username)!").bold().font(Font.custom( "DancingScript-Bold", size: 40)).padding()
                NavigationLink(destination: ChildrenListView(presentAddChild: false), isActive: $isShowingChildrenView) {}
                NavigationLink(destination: MealSuggestionView(viewModel: MealSuggestionModel()), isActive: $isShowingInfoView) {}
                NavigationLink(destination: CookbookView(model: model), isActive: $isShowingCookbook) {}
                Spacer ().frame(height: 30)
                Button("\(Image(systemName: "person.fill")) Check My Children") {
                    isShowingChildrenView = true
                    logger.log("Loading children list")
                }.padding().clipShape(Capsule()).foregroundColor(Color.green).font(Font.headline)
                
                Spacer().frame(height: 10)
                Button("\(Image(systemName: "list.bullet.circle")) Meal suggesstions") {
                    isShowingInfoView = true
                    logger.log("Loading meal suggestions")
                }.padding().clipShape(Capsule()).foregroundColor(Color.green).font(Font.headline)
                Spacer().frame(height: 10)
                Button("\(Image(systemName: "book.closed.fill")) My Cookbook") {
                    isShowingCookbook = true
                    logger.log("Loading cookbook")
                }.padding().foregroundColor(Color.green).font(Font.headline)
            }
            .toolbar {
                Button {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                            scheduleNotifications = true
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                } label: {
                    Image(systemName: "bell.fill").foregroundColor(.green)
                }

            }
        }
        .frame( maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("veggies").resizable())
        .ignoresSafeArea().opacity(0.9)
        .sheet(isPresented: $scheduleNotifications) {
            ScheduleNotificationsView(model)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    private static let model: VeggieTrackerModel = MockModel()
    
    static var previews: some View {
        ContentView()
            .environmentObject(model)
    }
}
