//
//  ChildView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI


struct ChildView: View {
    
    @EnvironmentObject var model: VeggieTrackerModel
    
    @ObservedObject var child: Child
    
    @State var presentAddMeal = false
    @State var presentEditChild = false
    @State var presentAlertMessage = false
    @State var presentCookbook = false
    @State var goToCookbook = false
    @State var selectedMeals = Set<Meal>()
    
    init(child: Child) {
        self.child = child
    }
    
    func currentChild() -> Int {
        guard let index = model.children.firstIndex(of: child) else {
            return 0
        }
        return index
    }
    
    var body: some View {
        VStack{
            VStack{
                Text(child.name).font(Font.custom( "DancingScript-Bold", size: 40))
                Text(child.description).font(Font.custom( "DancingScript-Bold", size: 30)).foregroundColor(Color.mint)
            }
            List(model.children[currentChild()].meals, id: \.self) {
                meal in
                NavigationLink(destination: MealView(meal: meal, child: child, editOption: true, addOption: false)){
                    HStack {
                        Text(meal.name)
                        Spacer()
                        meal.grade
                    }
                }
            }
            .sheet(isPresented: $presentAddMeal) {
                EditMeal(model.children[currentChild()], id: nil, model: model)
            }
            .sheet(isPresented: $presentCookbook) {
                NavigationView{
                    VStack {
                        NavigationLink(destination: CookbookView(model: model), isActive: $goToCookbook) {}
                        List(model.meals, id: \.self, selection: $selectedMeals) {
                            meal in
                            Text(meal.name)
                        }
                        Spacer()
                        Button(action: {
                            goToCookbook = true
                        }){
                            Text("Check my Cookbook \(Image(systemName: "book.closed.fill"))")
                        }
                    }
                    .environment(\.editMode, .constant(EditMode.active))
                    .toolbar {
                        ToolbarItem(placement: .primaryAction) {
                            Button(action: {
                                for meal in selectedMeals {
                                    if !child.meals.contains(meal) {
                                        if let child = model.child(child.id) {
                                            child.save(meal)
                                            model.save(child)
                                            model.save(meal)
                                        }
                                    }
                                }
                                presentCookbook = false
                            }){
                                Text("Save")
                            }
                        }
                        ToolbarItem(placement: .cancellationAction){
                            Button (action: {presentCookbook = false}){
                                Text("Cancel")
                            }
                        }
                    }
                    
                }
            }
        }.toolbar {
            ToolbarItem(placement: .automatic) {
                addButton
            }
            ToolbarItem(placement: .primaryAction) {
                Button(action: {self.presentEditChild = true}){
                    Text("edit")
                }
            }
        }.sheet(isPresented: $presentEditChild) {
            EditChild(model, id: child.id)
        }
    }
    
    private var addButton: some View {
        
        Button(action: { self.presentAlertMessage = true
        }) {
            Image(systemName: "plus")
        }.alert("Add new meal / select from cookbook",isPresented: $presentAlertMessage) {
            Button(action: {presentAddMeal = true
                presentAlertMessage = false
            }){
                Text("new meal")
                    .font(Font.bold(Font.body)())
            }
            Button(action: { presentAlertMessage = false
                presentCookbook = true
            }){
                Text("cookbook")
            }
            Button("Cancel", role: .cancel, action: {presentAlertMessage = false})
        }
    }
}

struct ChildView_Previews: PreviewProvider {
    private static let model: VeggieTrackerModel = MockModel()
    static var previews: some View {
        ChildView(child: Child(name: "Omar", age: 3, meals: [])).environmentObject(model)
    }
}
