//
//  Notification.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 21.09.22.
//

import Foundation


public enum FREQUENCY: String, Equatable, CaseIterable {
    case ONCE = "Once"
    case DAILY = "Daily"
    case WEEKLY = "Weekly"
    case MONTHLY = "Monthly"
}
public class Notification: Identifiable {
    public var id: UUID
    var title: String = ""
    var time: Date = Date()
    var frequency: FREQUENCY
    
    public init(id: UUID, title: String, time: Date, frequency: FREQUENCY) {
        self.id = id
        self.title = title
        self.time = time
        self.frequency = frequency
    }
}
