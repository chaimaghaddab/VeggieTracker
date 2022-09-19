//
//  EditMeal.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//


import SwiftUI
import CoreLocation
import Combine

/// View for editing a meal
struct EditMeal: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var viewModel: EditMealViewModel
    
    init(_ child: Child , id: Meal.ID, model: VeggieTrackerModel) {
        self.viewModel = EditMealViewModel(child, id: id, model: model)
    }
    /// depending on whether the meal exists already the title of the sheet is different
    var navigationTitle: String {
        viewModel.id == nil ? "Create Meal" : "Edit Meal"
    }
    
    var body: some View {
        NavigationView {
            self.form
            /// if the meal exists, the ingredients of the meal are loaded on the sheet
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle(navigationTitle, displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        /// Button for canceling the changes
                        Button(action : { self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Cancel").foregroundColor(Color.red)
                        },
                    trailing:
                        /// Button for saving the changes
                        Button(action : {
                            viewModel.save()
                            self.presentationMode.wrappedValue.dismiss()
                        }){
                            Text("Save")
                        }.disabled(viewModel.disableSaveButton))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var form: some View {
        Form {
            /// The meal's name
            Section(header: Text("Name")) {
                TextField("Name", text: $viewModel.name)
            }
            /// The meal's list of ingredients
            Section(header: Text("Ingredients")) {
                Section {
                    ForEach(0..<viewModel.ingredients.count, id: \.self) { index in
                        HStack {
                            TextField("Ingredient", text: $viewModel.ingredients[index])
                            /// The toggle is on if the ingredient is a vegetable
                            Toggle("", isOn: $viewModel.veggie[index])
                        }
                    }
                    Button(action:{
                        viewModel.ingredients.append("")
                        viewModel.veggie.append(false)
                    }) {
                        Text("Add more")
                    }
                }
            }
        }
    }
}



struct EditMeal_Previews: PreviewProvider {
    private static let meal = Meal(ingredients: [], name: "Chocolate Cake")
    private static let child = Child(name: "", age: 1, meals: [])
    static var previews: some View {
        EditMeal(child, id: meal.id, model: MockModel())
    }
}
