//
//  EditMeal.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 12.04.22.
//


import SwiftUI
import CoreLocation
import Combine

struct EditMeal: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var viewModel: EditMealViewModel
    
    @State var counter = 0
    
    init(_ child: Child , id: Meal.ID, model: VeggieTrackerModel) {
        self.viewModel = EditMealViewModel(child, id: id, model: model)
    }
    
    
    var navigationTitle: String {
        viewModel.id == nil ? "Create Meal" : "Edit Meal"
    }
    
    var body: some View {
        NavigationView {
            self.form
                .onAppear(perform: viewModel.updateStates)
                .navigationBarTitle(navigationTitle, displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        Button(action : { self.presentationMode.wrappedValue.dismiss()
                            
                        }){
                            Text("Cancel").foregroundColor(Color.red)
                        },
                    trailing:
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
            Section(header: Text("Name")) {
                TextField("Name", text: $viewModel.name)
            }
            
            Section(header: Text("Ingredients")) {
                Section {
                    ForEach(0..<viewModel.ingredients.count, id: \.self) { index in
                        HStack {
                            TextField("Ingredient", text: $viewModel.ingredients[index])
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
