//
//  Notification.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 21.09.22.
//

import Foundation


public enum FREQUENCY: String, Equatable, CaseIterable, Codable {
    case ONCE = "Once"
    case DAILY = "Daily"
    case WEEKLY = "Weekly"
    case MONTHLY = "Monthly"
}
public class Notification: Identifiable, Codable {
    public var id: UUID
    var title: String = ""
    var time: Date = Date()
    var frequency: FREQUENCY
    var child: Child.ID?
    var allChildren: Bool
    var meal: Meal.ID?
    
    public init(id: UUID, title: String, time: Date, frequency: FREQUENCY, child: Child.ID, allChildren: Bool, meal: Meal.ID) {
        self.id = id
        self.title = title
        self.time = time
        self.frequency = frequency
        self.child = child
        self.allChildren = allChildren
        self.meal = meal
    }
    public init() {
        self.id = UUID()
        self.title = ""
        self.time = .now
        self.frequency = .ONCE
        self.child = nil
        self.allChildren = true
        self.meal = UUID()
    }
    
    public init() {
        self.id = UUID()
        self.title = ""
        self.time = .now
        self.frequency = .ONCE
        self.allChildren = true
    }
}
