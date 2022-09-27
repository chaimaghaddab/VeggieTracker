//
//  VeggieTrackerModel.swift
//  VeggieTracker (iOS)
//
//  Created by Chaima Ghaddab on 13.04.22.
//

import Foundation
import Combine
import os
import WidgetKit

/// The app's global model
public class VeggieTrackerModel: ObservableObject {
    @Published public var user: User
    @Published public var children: [Child] {
        didSet {
            writeChildren(children)
        }
    }
    @Published public var meals: [Meal] {
        didSet {
            writeMeals(meals)
        }
    }
    @Published public internal(set) var serverError: VeggieServiceError?
    @Published public internal(set) var notifications: [Notification]
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "Model")
    
    /// A list containing ingredients that are classified as veggies
    static var veggieList = ["carrot", "artichoke", "broccoli", "caper", "cauliflower", "avocado", "breadfruit", "chickpea", "cucumber", "eggplant", "tomato", "pumpkin", "zucchini", "beet", "celery", "cabbage", "fennel", "spinach", "garlic", "onion", "kale", "paprika", "pepper", "potatoe", "aubergine", "shallots"]
    
    public init(user: User, children: [Child] = [], meals: [Meal] = [], notifications: [Notification]) {
        self.user = user
        self.children = children
        self.meals = meals
        self.notifications = notifications
    }
    
    ///  returns child with id
    public func child(_ id: Child.ID?) -> Child? {
        children.first { $0.id == id }
    }
    
    ///  returns meal with id
    public func meal(_ id: Meal.ID) -> Meal? {
        meals.first { $0.id == id }
    }
    
    
    ///  updates an existing child
    private func update(_ child: Child) {
        if let updateChild = self.child(child.id) {
            updateChild.name = child.name
            updateChild.meals = child.meals
            updateChild.age = child.age
            self.children = children
        }
    }
    
    ///  updates an existing meal
    private func update(_ meal: Meal) {
        if let updateMeal = self.meal(meal.id) {
            updateMeal.name = meal.name
            updateMeal.ingredients = meal.ingredients
            self.meals = self.meals
        }
    }
    
    /// Either add a new child or saves the editing of an existong child
    public func save(_ child: Child) {
        if self.child(child.id) != nil{
            update(child)
            logger.log("Added child \(child.name)")
        }
        else {
            children.append(child)
            logger.log("Edited child \(child.name)")
        }
        self.children = self.children
    }
    
    /// Either add a new meal or saves the editing of an existong meal
    public func save(_ meal: Meal) {
        if self.meal(meal.id) != nil{
            update(meal)
            logger.log("Added meal \(meal.name)")
        }
        else {
            meals.append(meal)
            logger.log("Added meal \(meal.name)")
        }
        self.meals = self.meals
        WidgetCenter.shared.reloadAllTimelines()
    }
    
   
    func writeMeals(_ meals: [Meal]) -> Void {
        do {
            let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VeggieApp.Data")?.appendingPathComponent("MealData.json")
            try JSONEncoder()
                .encode(meals)
                .write(to: fileURL!)
        } catch {
            print("error writing data")
        }
    }
    
    public func readMeals() -> Void {
        do {
            let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VeggieApp.Data")?.appendingPathComponent("MealData.json")
//                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                .appendingPathComponent("MealData.json")
            guard let fileURL = fileURL else {
                return
            }
            let data = try Data(contentsOf: fileURL)
            let mealData = try JSONDecoder().decode([Meal].self, from: data)
            self.meals = mealData
        } catch {
            print(error)
        }
    }
    func writeChildren(_ children: [Child]) -> Void {
        do {
            let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VeggieApp.Data")?.appendingPathComponent("ChildrenData.json")
            try JSONEncoder()
                .encode(children)
                .write(to: fileURL!)
        } catch {
            print("error writing data")
        }
    }
    
    public func readChildren() -> Void {
        do {
            let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.VeggieApp.Data")?.appendingPathComponent("ChildrenData.json")
//                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                .appendingPathComponent("MealData.json")
            guard let fileURL = fileURL else {
                return
            }
            let data = try Data(contentsOf: fileURL)
            let childrenData = try JSONDecoder().decode([Child].self, from: data)
            self.children = childrenData
        } catch {
            print(error)
        }
    }
    
}
