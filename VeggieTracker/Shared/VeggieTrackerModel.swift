//
//  VeggieTrackerModel.swift
//  VeggieTracker (iOS)
//
//  Created by Chaima Ghaddab on 13.04.22.
//

import Foundation
import Combine
import os

public class VeggieTrackerModel: ObservableObject {
    @Published public internal(set) var user: User
    @Published public internal(set) var children: [Child]
    @Published public internal(set) var meals: [Meal]
    @Published public internal(set) var serverError: VeggieServiceError?
    @Published public internal(set) var notifications: [Notification]
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "Model")
    
    // A list containing ingredients that are classified as veggies
    static var veggieList = ["carrot", "artichoke", "broccoli", "caper", "cauliflower", "avocado", "breadfruit", "chickpea", "cucumber", "eggplant", "tomato", "pumpkin", "zucchini", "beet", "celery", "cabbage", "fennel", "spinach", "garlic", "onion", "kale", "paprika", "pepper", "potatoe", "aubergine", "shallots"]
    
    public init(user: User, children: [Child] = [], meals: [Meal] = []) {
        self.user = user
        self.children = children
        self.meals = meals
        self.notifications = []
    }
    
    //  returns child with id
    public func child(_ id: Child.ID?) -> Child? {
        children.first { $0.id == id }
    }
    
    //  returns meal with id
    public func meal(_ id: Meal.ID) -> Meal? {
        meals.first { $0.id == id }
    }
    
    //  updates an existing child
    private func update(_ child: Child) {
        if let updateChild = self.child(child.id) {
            updateChild.name = child.name
            updateChild.meals = child.meals
            updateChild.age = child.age
        }
    }
    
    //  updates an existing meal
    private func update(_ meal: Meal) {
        if let updateMeal = self.meal(meal.id) {
            updateMeal.name = meal.name
            updateMeal.ingredients = meal.ingredients
        }
    }
    
    // Either add a new child or saves the editing of an existong child
    public func save(_ child: Child) {
        if self.child(child.id) != nil{
            update(child)
            logger.log("Added child \(child.name)")
        }
        else {
            children.append(child)
            logger.log("Edited child \(child.name)")
        }
    }
    
    // Either add a new meal or saves the editing of an existong meal
    public func save(_ meal: Meal) {
        if self.meal(meal.id) != nil{
            update(meal)
            logger.log("Added meal \(meal.name)")
        }
        else {
            meals.append(meal)
            logger.log("Added meal \(meal.name)")
        }
    }
}
