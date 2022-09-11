//
//  CookbookView.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 18.04.22.
//

import SwiftUI

struct CookbookView: View {
    var model: VeggieTrackerModel
    
    init(model: VeggieTrackerModel) {
        self.model = model
    }
    var body: some View {
        VStack {
            Text("My Meals").font(Font.custom( "DancingScript-Bold", size: 40)).frame(alignment: .topLeading)
            ACarousel(model.meals) { meal in
                VStack{
                    MealView(meal: meal, child: Child(name: "", age: 0, meals: []), editOption: false, addOption: false)
                    if model.meals[0] == meal {
                        HStack{
                            Spacer()
                            Image(systemName: "arrowshape.turn.up.right.fill").frame(width: 10, height: 10)
                        }
                    }
                    else if model.meals[model.meals.count-1] == meal {
                        HStack{
                            Image(systemName: "arrowshape.turn.up.backward.fill").frame(width: 10, height: 10)
                            Spacer()
                        }
                    }
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

struct CookbookView_Previews: PreviewProvider {
    static var previews: some View {
        CookbookView(model: MockModel())
    }
}
