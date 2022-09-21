//
//  EditChildViewModel.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//

import Combine
import Foundation
import CoreLocation
import SwiftUI
import os

class EditChildViewModel: ObservableObject {
    /// The child's name
    @Published var name: String = ""
    /// The child's age
    @Published var age : Int = 0
    /// The child's registered meals
    @Published var meals = [Meal]()
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "EditChild")
    
    /// The child's ID
    var id: Child.ID
    var model: VeggieTrackerModel
    
    /// The save button is disabled as long as the child's name is empty or the age is 0
    var disableSaveButton: Bool {
        self.name == "" || self.age == 0
    }
    
    init(_ model: VeggieTrackerModel, id: Child.ID) {
        self.model = model
        self.id = id
    }
    
    /// Updates an existing child
    func updateStates() {
        guard let child = model.child(id) else {
            return
        }
        self.name = child.name
        self.meals = child.meals
        self.age = child.age
    }
    
    /// Either updates an existng child or adds a new child to the user's account
    func save() {
        guard let child = model.child(self.id) else {
            let child = Child(id: UUID(), name: name, age: age, meals: meals)
            model.save(child)
            logger.log("Added a new child \(child.name): \(child.description)")
            return
        }
        child.name = self.name
        child.meals = self.meals
        child.age = self.age
        model.save(child)
        logger.log("Edited child \(child.name): \(child.description)")
    }
}


