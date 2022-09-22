//
//  ScheduleNotificationsViewModel.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 21.09.22.
//

import Foundation
import UserNotifications

class ScheduleNotificationsViewModel: ObservableObject {
    var model: VeggieTrackerModel
    @Published var title: String = ""
    @Published var time: Date = Date()
    @Published var frequency: FREQUENCY = .ONCE
    @Published var allChildren: Bool = true
    @Published var childSelection : UUID?
    
    var disableSaveButton: Bool {
      return title == ""
    }
    
    init(_ model: VeggieTrackerModel) {
        self.model = model
        
    }
    
    //  Updates an existing child
    func updateStates() {
    }
    
    //  Either updates an existng child or adds a new child to the user's account
    func save() {
        model.notifications.append(Notification(id: UUID(), title: title, time: time, frequency: frequency, child: childSelection, allChildren: allChildren))
        let content = UNMutableNotificationContent()
        let child = model.child(childSelection)
        content.title = title
        content.subtitle = allChildren ? "Reminder: it's your children's \(title) time!" : "Reminder: it's \(child!.name)'s \(title) time!"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        var date = DateComponents()
        date.hour = Calendar.current.component(.hour, from: time)
        date.minute = Calendar.current.component(.minute, from: time)
        print(date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
}
