//
//  Child.swift
//  
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation
import Combine

public final class Child : ObservableObject, Codable {
    /// Child's ID
    @Published public var id: UUID?
    /// Child's name
    @Published public var name: String
    /// Child's age
    @Published public var age: Int
    /// Child's meals list
    @Published public var meals: [Meal]
    
    public init(id: UUID? = nil, name: String, age: Int, meals: [Meal]) {
        self.id = id ?? nil
        self.name = name
        self.age = age
        self.meals = meals
    }
    
    
    ///  Updating an existing meal
    private func update(_ meal: Meal){
        if let updateMeal = self.meals.first(where: {
            $0.id == meal.id
        }){
            updateMeal.name = meal.name
            updateMeal.ingredients = meal.ingredients
        }
        self.meals = self.meals
    }
    
    ///  Either editing an existing meal or adding a new meal
    public func save(_ meal: Meal){
        if self.meal(meal.id) != nil{
            update(meal)
        }
        else {
            meals.append(meal)
            self.meals = self.meals
        }
    }
    
    ///  Get a meal by id
    public func meal(_ id: Meal.ID?) -> Meal? {
        meals.first(where: { $0.id == id })
    }
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case age = "age"
        case meals = "meals"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int.self, forKey: .age)
        self.meals = try container.decode([Meal].self, forKey: .meals)
      }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.age, forKey: .age)
        try container.encode(self.meals, forKey: .meals)
    }
}
    
    
    /// child's description: age + year(s)
    extension Child: CustomStringConvertible {
        public var description: String {
            var desc = "year"
            if age > 1 {
                desc += "s"
            }
            return "\(age) \(desc)"
        }
    }
    
    /// children are comparable and sortable based on age
    extension Child: Comparable {
        public static func == (lhs: Child, rhs: Child) -> Bool {
            lhs.name == rhs.name && lhs.age == rhs.age
        }
        
        public static func < (lhs: Child, rhs: Child) -> Bool {
            lhs.age < rhs.age
        }
    }
    
    extension Child: Identifiable { }
    extension Child: Hashable {
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(age)
        }
    }
    
