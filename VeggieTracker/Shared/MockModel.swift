//
//  MockModel.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation
import SwiftUI

public class MockModel : VeggieTrackerModel {
    
    
    public convenience init() {
        let Charlotte = Child(id: UUID(), name: "Charlotte", age: 6, meals: [])
        let Paul = Child(id: UUID(), name: "Paul", age: 3, meals: [])
        let Lara = Child(id: UUID(), name: "Lara", age: 1, meals: [])
        
        let children = [Charlotte, Paul, Lara]
        
        let meal1 = Meal(UUID(uuidString: "0bbb0214-3a6d-11ed-a261-0242ac120002"),
                         ingredients: [Ingredient(name:"carrot", veggie: true)],
                         name: "Carrot cake")
        
        let meal2 = Meal(UUID(uuidString: "15b42746-3a6d-11ed-a261-0242ac120002"),
                          ingredients: [Ingredient(name:"broccoli", veggie: false), Ingredient(name:"carrot", veggie: false)],
                          name: "Roasted Veggies")
        
        let meal3 = Meal(UUID(uuidString: "00000000-0000-4000-8000-000000000000"),
                         ingredients: [Ingredient(name:"potato", veggie: true)],
                         name: "Oven Potato")
        
        let meals = [meal1, meal3]
        
        children[0].meals = meals
        children[1].meals.append(meal1)
        
        let user = User(id: UUID(), username: "Natalia")
        
        let notification1 = Notification(id: UUID(), title: "Dummy Notification", time: .now, frequency: .ONCE, child: Charlotte.id, allChildren: false)
        let notification2 = Notification(id: UUID(), title: "Dummy Notification 2", time: .now.addingTimeInterval(1000), frequency: .ONCE, child: Charlotte.id, allChildren: false)
        
        self.init(user: user, children: children, meals: meals, notifications: [notification1, notification2])
    }
}
