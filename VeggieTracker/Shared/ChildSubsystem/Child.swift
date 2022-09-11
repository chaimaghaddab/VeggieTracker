//
//  Child.swift
//  
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation
import Combine

public class Child : ObservableObject {
    @Published public var id: UUID?
    @Published public var name: String
    @Published public var age: Int
    @Published public var meals: [Meal]
    
    public init(id: UUID? = nil, name: String, age: Int, meals: [Meal]) {
        self.id = id ?? nil
        self.name = name
        self.age = age
        self.meals = meals
    }
    
    
    //  Updating an existing meal
    private func update(_ meal: Meal){
        if let updateMeal = self.meals.first(where: {
            $0.id == meal.id
        }){
            updateMeal.name = meal.name
            updateMeal.ingredients = meal.ingredients
        }
    }
    
    //  Either editing an existing meal or adding a new meal
    public func save(_ meal: Meal){
        if self.meal(meal.id) != nil{
            update(meal)
        }
        else {
            meals.append(meal)
        }
    }
    
    //  Get a meal by id
    public func meal(_ id: Meal.ID?) -> Meal? {
        meals.first(where: { $0.id == id })
    }
}

extension Child: CustomStringConvertible {
    public var description: String {
        var desc = "year"
        if age > 1 {
            desc += "s"
        }
        return "\(age) \(desc)"
    }
}

extension Child: Comparable {
    public static func == (lhs: Child, rhs: Child) -> Bool {
        lhs.name == rhs.name && lhs.age == rhs.age
    }
    
    public static func < (lhs: Child, rhs: Child) -> Bool {
        lhs.age < rhs.age
    }
}

extension Child: Identifiable { }

