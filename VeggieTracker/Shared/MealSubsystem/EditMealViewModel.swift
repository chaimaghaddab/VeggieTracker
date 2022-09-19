//
//  EditMealViewModel.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//

import Combine
import Foundation
import CoreLocation
import SwiftUI
import os

/// The view model for the meal editing view
class EditMealViewModel: ObservableObject {
    /// The list of ingredients
    @Published var ingredients : [String] = [""]
    /// the name of the meal
    @Published var name: String = ""
    /// Whether the ingredients are veggie
    @Published var veggie: [Bool] = [true]
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "EditMeal")
    
    var id: Meal.ID
    @ObservedObject var child: Child
    var model: VeggieTrackerModel
    
    
    init(_ child: Child, id: Meal.ID, model: VeggieTrackerModel) {
        self.child = child
        self.id = id
        self.model = model
    }
    
    /// the save button is disabled as long as the name is empty or the list of ingredients is empty
    var disableSaveButton: Bool {
        self.name == "" || self.ingredients.isEmpty || self.ingredients == [""]
    }
    
    /// updates the form with the information from the meal's instance
    func updateStates() {
        if let child = model.child(child.id){
            if let meal = child.meal(self.id) {
                self.name = meal.name
                self.ingredients = meal.ingredients.map({ ingredient in
                    ingredient.name
                })
                self.veggie = meal.ingredients.map({ingredient in
                    ingredient.veggie == true
                })
            }
        }
    }
    
    ///  Updates or adds a new meal based on the edit meal sheet
    func save(){
        for i in (0..<veggie.count) {
            let ingredient = ingredients[i].lowercased()
            if ((veggie[i]) && (!VeggieTrackerModel.veggieList.contains(ingredient))) {
                VeggieTrackerModel.veggieList.append(ingredient)
            }
        }
        
        let newIngredients = ingredients.map({ ingredient in
            Ingredient(name: ingredient.lowercased(), veggie: veggie[ingredients.firstIndex(of: ingredient).unsafelyUnwrapped])})
        
        if let child = model.child(child.id){
            guard let meal = child.meal(self.id) else {
                let meal = Meal(UUID(), ingredients: newIngredients, name: name)
                child.save(meal)
                model.save(meal)
                model.save(child)
                logger.log("Added \(meal.description) for child \(child.name)")
                return
            }
            meal.name = self.name
            meal.ingredients = newIngredients
            child.save(meal)
            model.save(meal)
            model.save(child)
            logger.log("Edited \(meal.description) for child \(child.name)")
        }
    }
}



