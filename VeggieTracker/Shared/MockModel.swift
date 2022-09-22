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
                         name: "Carrot_cake"
        )
        
        let meal2 = Meal( UUID(uuidString: "15b42746-3a6d-11ed-a261-0242ac120002"),
                          ingredients: [Ingredient(name:"broccoli", veggie: true), Ingredient(name:"carrot", veggie: true)],
                          name: "Roasted_Veggies"
        )
        
        let meals = [
            meal1,
            meal2,
            Meal(UUID(uuidString: "1f21c036-3a6d-11ed-a261-0242ac120002"),
                 ingredients: [Ingredient(name:"potato", veggie: true)],
                 name: "Oven_Potato")
        ]
        
        children[0].meals = meals
        children[1].meals.append(meal1)
        
        let user = User(id: UUID(), username: "Natalia")
        let notification1 = Notification(id: UUID(), title: "Dummy Notification", time: .now, frequency: .ONCE, child: Charlotte.id, allChildren: false)
        self.init(user: user, children: children, meals: meals, notifications: [notification1])
    }
}
