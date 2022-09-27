//
//  ContentView.swift
//  Shared
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import os
import UserNotifications

/// Main view after launching the app
struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    /// The app model is tracked throughout the app
    @EnvironmentObject private var model: VeggieTrackerModel
    /// If true the view representing the children list is opened
    @State private var isShowingChildrenView = false
    ///if true the view representing suggestions for meals is opened
    @State private var isShowingInfoView = false
    /// if true the view representing the cookbook of the parent(user) is opened
    @State private var isShowingCookbook = false
    @State private var scheduleNotifications = false
    @State private var authorizationDeniedAlert = false
    @State private var selectedMeal: Meal?
    @State private var selectedNotification: Notification?
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "ContentView")
    
    var body: some View {
        NavigationView  {
            VStack {
                /// Welcoming sentence
                Text("Hello, \(model.user.username)!").bold().font(Font.custom( "DancingScript-Bold", size: 40)).padding()
                /// Link to the list of children
                NavigationLink(destination: ChildrenListView(presentAddChild: false), isActive: $isShowingChildrenView) {}
                /// Link to the meal suggestion view
                NavigationLink(destination: MealSuggestionView(viewModel: MealSuggestionModel()), isActive: $isShowingInfoView) {}
                /// Link to the user's cookbook view
                NavigationLink(destination: CookbookView(model: model), isActive: $isShowingCookbook) {}
                
                Spacer ().frame(height: 30)
                /// Button to the list of children
                Button("\(Image(systemName: "person.fill")) Check My Children") {
                    isShowingChildrenView = true
                    logger.log("Loading children list")
                }.padding().clipShape(Capsule()).foregroundColor(Color.green).font(Font.headline)
                
                Spacer().frame(height: 10)
                /// Button to the meal suggestion view
                Button("\(Image(systemName: "list.bullet.circle")) Meal suggesstions") {
                    isShowingInfoView = true
                    logger.log("Loading meal suggestions")
                }.padding().clipShape(Capsule()).foregroundColor(Color.green).font(Font.headline)
                
                Spacer().frame(height: 10)
                /// Button to the cookbook view
                Button("\(Image(systemName: "book.closed.fill")) My Cookbook") {
                    isShowingCookbook = true
                    logger.log("Loading cookbook")
                }.padding().foregroundColor(Color.green).font(Font.headline)
            }
            .toolbar {
                Button {
                    let currentCenter = UNUserNotificationCenter.current()
                    currentCenter.getNotificationSettings { settings in
                        let status = settings.authorizationStatus
                        if status == .denied || status == .notDetermined {
                            self.authorizationDeniedAlert = true
                        }
                    }
                    currentCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                            authorizationDeniedAlert = false
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
        .alert(isPresented: $authorizationDeniedAlert) {
            Alert(
                title: Text("Notifications Unothorized"),
                message: Text("Please enable notifications for the App VeggieTracker in the settings!"),
                primaryButton: .default(Text("Settings")) {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                },
                secondaryButton: .cancel()
            )
            
        }
        .sheet(isPresented: $scheduleNotifications) {
            ScheduleNotificationsView(model)
        }
        .sheet(item: $selectedMeal) { meal in
            MealView(meal: meal, child: Child(name: "", age: 0, meals: []), editOption: false, addOption: false)
        }
        .sheet(item: $selectedNotification) { notification in
            NotificationView(notification: notification)
        }
        .onOpenURL { url in
            print(url)
            guard url.scheme == "veggie" else { return }
            
            if(url.host == "meals") { // TODO: Once the @AppStorage is done, make an API call here and then get the meal by id
                let mealID = url.pathComponents[1]
                guard let mealUUID = UUID(uuidString: mealID),
                      let meal = model.meal(mealUUID) else { return }
                selectedMeal = meal
            } else if url.host == "notifications" {
                let notificationID = url.pathComponents[1]
                guard let notificationUUID = UUID(uuidString: notificationID),
                      let notification = model.notification(notificationUUID) else { return }
                selectedNotification = notification
            }
        }.onAppear {
            model.readMeals()
            model.readChildren()
            model.readNotifications()
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
