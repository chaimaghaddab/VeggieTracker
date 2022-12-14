//
//  Info.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import SwiftUI
import os

/// The view that represents the list of meals from the API www.themealdb.com
struct MealSuggestionView: View {
    @StateObject var viewModel: MealSuggestionModel = MealSuggestionModel()
    @State private var searchText = ""
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "MealView")
    
    var body: some View {
        /// List of meals fetched from the API
        List(searchResult, id: \.self) { meal in
            NavigationLink(destination: MealView(meal: meal, child: Child(name: "", age: 0, meals: []), editOption: false, addOption: true)) {
                HStack {
                    Text(meal.name)
                    Spacer()
                    meal.grade
                }
            }
        }.task {
            do {
                try await viewModel.getAllMeals()
            }
            catch VeggieServiceError.missingURL {
                logger.log("Missing URL")
            }
            catch VeggieServiceError.failedFetch {
                logger.log("Failed to fetch data from API")
            }
            catch {
                print(error)
            }
        }
        /// text field to search for meals based on ingredients
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Type ingredient")
        .navigationTitle("Meals").font(Font.custom( "DancingScript-Bold", size: 25))
        .environmentObject(viewModel)
    }
    
    /// result of the search based on ingredients
    var searchResult: [Meal] {
        if searchText.isEmpty {
            return viewModel.meals
        }
        else {
            return viewModel.meals.filter{
                $0.veggies.map{$0.name}.contains(searchText.lowercased())
            }
        }
    }
}


struct MealSuggestion_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = MealSuggestionModel()
        MealSuggestionView(viewModel: viewModel)
    }
}
