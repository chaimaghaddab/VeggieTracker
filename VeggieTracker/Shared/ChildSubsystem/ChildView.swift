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
    
    /// if set to true, the sheet for adding a meal is presented
    @State var presentAddMeal = false
    /// if set to true, the sheet for editing a child's profile is presented
    @State var presentEditChild = false
    /// if set to true, an alert message is presented giving a choice for manually adding a meal or choosing from cookbook
    @State var presentAlertMessage = false
    /// if set to true, the cookbook of the user is presented
    @State var presentCookbook = false
    /// indicates to redirect to the cookbook
    @State var goToCookbook = false
    /// set of selected meals
    @State var selectedMeals = Set<Meal>()
    
    
    init(child: Child) {
        self.child = child
    }
    
    /// returns the index of the current child
    func currentChild() -> Int {
        guard let index = model.children.firstIndex(of: child) else {
            return 0
        }
        return index
    }
    
    var body: some View {
        let notifications =  model.notifications.filter { notification in
            notification.allChildren || notification.child == child.id
        }
        let meals = model.children[currentChild()].meals
        return VStack{
            VStack{
                /// child's name
                Text(child.name).font(Font.custom( "DancingScript-Bold", size: 40))
                /// child's description indicates age
                Text(child.description).font(Font.custom( "DancingScript-Bold", size: 30)).foregroundColor(Color.mint)
            }
            Spacer()
            VStack {
                if !meals.isEmpty {
                    Spacer()
                    Section(header: Text("Recipes").font(.title)) {
                        /// List of child's registred meals
                        List(meals, id: \.self) {
                            meal in
                            /// a link to the meal in the list
                            NavigationLink(destination: MealView(meal: meal, child: child, editOption: true, addOption: false)){
                                HStack {
                                    /// Meal's name
                                    Text(meal.name)
                                    Spacer()
                                    /// Meal's degree on vegetables
                                    meal.grade
                                }
                            }
                        }
                    }
                }
                if !notifications.isEmpty {
                    Section(header: Text("Scheduled melas").font(.title)) {
                        List(notifications, id: \.id) { notification in
                            HStack{
                                Text(notification.title)
                                Spacer()
                                Text(notification.time.formatted(date: .omitted,time: .shortened))
                            }
                        }
                    }
                }
            }
        }
        /// Sheet for adding a meal
        .sheet(isPresented: $presentAddMeal) {
            EditMeal(child, id: nil, model: model)
        }
        /// Sheet for presenting cookbook
        .sheet(isPresented: $presentCookbook) {
            NavigationView{
                VStack {
                    /// Link to redirect to cookbook
                    NavigationLink(destination: CookbookView(model: model), isActive: $goToCookbook) {}
                    /// List of selected meals
                    List(model.meals, id: \.self, selection: $selectedMeals) {
                        meal in
                        Text(meal.name)
                    }
                    Spacer()
                    /// Button to redirect to cookbook
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
                                    /// save changes for the corresponding child
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
                    /// Button for canceling changes
                    ToolbarItem(placement: .cancellationAction){
                        Button (action: {presentCookbook = false}){
                            Text("Cancel")
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .automatic) {
                /// Button for adding a meal
                addButton
            }
            /// Button for editing a child's profile
            ToolbarItem(placement: .primaryAction) {
                Button(action: {self.presentEditChild = true}){
                    Text("edit")
                }
            }
        }.sheet(isPresented: $presentEditChild) {
            EditChild(model, id: child.id)
        }
    }
    /// Button for adding a new meal manually of from cookbook
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
