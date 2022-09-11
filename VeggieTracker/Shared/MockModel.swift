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
        
        let meal1 = Meal(UUID(),
                         ingredients: [Ingredient(name:"carrot", veggie: true)],
                         name: "Carrot cake"
        )
        
        let meal2 = Meal( UUID(),
                          ingredients: [Ingredient(name:"broccoli", veggie: true), Ingredient(name:"carrot", veggie: true)],
                          name: "Roasted Veggies"
        )
        
        let meals = [
            meal1,
            meal2,
            Meal(UUID(),
                 ingredients: [Ingredient(name:"potatoe", veggie: true)],
                 name: "Oven Potatoe")
        ]
        
        children[0].meals = meals
        children[1].meals.append(meal1)
        
        let user = User(id: UUID(), username: "Natalia")
        
        self.init(user: user, children: children, meals: meals)
    }
}
