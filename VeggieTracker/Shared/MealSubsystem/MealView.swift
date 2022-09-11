//
//  MealView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//

import SwiftUI
import os

struct MealView: View {
    @ObservedObject var child : Child
    @ObservedObject var meal: Meal
    
    var editOption: Bool
    var addOption: Bool
    
    @EnvironmentObject var model: VeggieTrackerModel
    @State var presentEditMeal = false
    @State var presentAlertMessage = false
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "MealView")
    
    init(meal: Meal, child: Child, editOption: Bool, addOption: Bool) {
        self.meal = meal
        self.child = child
        self.editOption = editOption
        self.addOption = addOption
    }
    
    var body: some View {
        List {
            VStack{
                Text(meal.name).font(Font.custom( "DancingScript-Bold", size: 40))
                Spacer().frame(height: 5)
                meal.grade
                
                if meal.imageUrl != "" {
                    self.image
                }
                Spacer().frame(height: 50)
                
                Text("Ingredients:").font(Font.headline)
                Spacer()
                self.ingredients
                
                Spacer().frame(height: 50)
                
                if meal.tips != nil && meal.tips != "" {
                    Text("Instructions:").font(Font.headline)
                    self.tips
                }
            }.padding()
        }.toolbar {
            ToolbarItem(placement: .primaryAction){
                if editOption {
                    Button(action: {presentEditMeal = true}){
                        Text("edit")
                    }
                }
                else {
                    if addOption {
                        self.addButton
                    }
                }
            }
        }.sheet(isPresented: $presentEditMeal){
            EditMeal(child, id: meal.id, model: model)
        }
    }
    
    var image: some View {
        AsyncImage(url: URL(string: meal.imageUrl!),
                   content: { image in
            image.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 300, maxHeight: 300)
        },
                   placeholder: {
            ProgressView()
        })
    }
    
    var ingredients: some View {
        ForEach(meal.ingredients, id: \.self) {
            ingredient in
            HStack(alignment: .center) {
                Text(ingredient.name.lowercased())
                Spacer()
                if ingredient.veggie {
                    Image(systemName: "leaf.fill").foregroundColor(Color.green)
                }
            }
        }
    }
    
    var tips: some View {
        VStack(alignment: .leading){
            Spacer()
            let instructionList = meal.tips!.split(whereSeparator: \.isNewline).map { value in
                String(value)
            }
            ForEach(1 ... instructionList.count, id: \.self) {
                index in
                let instruction = instructionList[index-1]
                Text(" \(index). \(instruction)")
                Spacer()
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            presentAlertMessage = true
        }) {
            Image(systemName: "plus")
        }.alert("This meal will be added to your cookbook!", isPresented: $presentAlertMessage) {
            Button(action: { model.meals.append(meal)
                presentAlertMessage = false
                logger.log("Added meal \(meal.name) to the cookbook")
            }) {
                    Text("Confirm")
                }
            Button("Cancel", role: .cancel) {presentAlertMessage = false}
        }
    }
}

struct MealView_Previews: PreviewProvider {
    static var previews: some View {
        let meal = Meal(ingredients: [], name: "Pasta")
        MealView(meal: meal, child: Child(name: "Omar", age: 3, meals: []), editOption: true, addOption: false)
    }
}
