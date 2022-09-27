//
//  CookbookView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 18.04.22.
//

import SwiftUI

/// The cookbook's view enclosing all the user's saved recipes
struct CookbookView: View {
    var model: VeggieTrackerModel
    
    init(model: VeggieTrackerModel) {
        self.model = model
    }
    var body: some View {
        VStack {
            Text("My Meals").font(Font.custom( "DancingScript-Bold", size: 40)).frame(alignment: .topLeading)
            if (!model.meals.isEmpty) {
                /// Carousel third-party package
                ACarousel(model.meals) { meal in
                    VStack{
                        /// For each meal the carousel presents the repective meal view
                        MealView(meal: meal, child: Child(name: "", age: 0, meals: []), editOption: false, addOption: false)
                        /// if it's the first meal, only an arrow to the right is displayed
                        if model.meals[0] == meal {
                            HStack{
                                Spacer()
                                Image(systemName: "arrowshape.turn.up.right.fill").frame(width: 10, height: 10)
                            }
                        }
                        /// if it's the last meal, only an arrow to the left is displayed
                        else if model.meals[model.meals.count-1] == meal {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.backward.fill").frame(width: 10, height: 10)
                                Spacer()
                            }
                        }
                        /// otherwise both arrows to the left and the right are displayed
                        else {
                            HStack{
                                Image(systemName: "arrowshape.turn.up.backward.fill").frame(width: 10, height: 10)
                                Spacer()
                                Image(systemName: "arrowshape.turn.up.right.fill").frame(width: 10, height: 10)
                            }
                        }
                    }.padding().cornerRadius(30)
                }.frame(alignment: .center)
            }
        }
    }
}

struct CookbookView_Previews: PreviewProvider {
    static var previews: some View {
        CookbookView(model: MockModel())
    }
}
