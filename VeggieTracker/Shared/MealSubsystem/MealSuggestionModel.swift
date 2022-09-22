//
//  MealSuggestionModel.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 13.04.22.
//

import Foundation
import os

/// Decodable struct reresenting the API's result
struct MealResult: Decodable {
    let idMeal: String
    let strMeal: String
}
/// Decodable struct representing the meals from the API
struct Meals1: Decodable {
    let meals: [APIMeal]
}
/// decodable struct for the list of meals decoded from the API's result
struct Meals: Decodable {
    let meals: [MealResult]
}
/// Decodable struct represeting a meal as in the API's JSON format with 20 ingredients
struct APIMeal: Decodable {
    let strMeal: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
}


public class MealSuggestionModel: ObservableObject {
    @Published public var meals = [Meal]()
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "MealSuggestion API")
    
    ///  function that fetches all meal from the public API given by the URL
    @MainActor
    func getAllMeals() async throws -> Void{
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/search.php?s=") else { throw VeggieServiceError.missingURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw VeggieServiceError.failedFetch
        }
        let decodedMeals = try JSONDecoder().decode(Meals.self, from: data)
        let result = decodedMeals.meals
        var meals = [Meal]()
        do {
            try await meals = getMealsById(meals: result)
        } catch {
            logger.log("Error happened while getting meals from API")
        }
        self.meals = meals
    }
    
    ///  function that returns all meals with given ids
    func getMealsById(meals: [MealResult]) async throws -> [Meal]{
        var returnMeals = [Meal]()
        for meal in meals {
            /// URL for the respective meals
            guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(meal.idMeal)") else {
                throw VeggieServiceError.missingURL }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                logger.log("Failed to fetch data from API")
                throw VeggieServiceError.failedFetch}
            /// list of decoded meals from the API's response
            let decodedMeals = try JSONDecoder().decode(Meals1.self, from: data)
            let decodedMeal = decodedMeals.meals[0]
            /// list of meal's ingredients
            let mealIngredients = [decodedMeal.strIngredient1, decodedMeal.strIngredient2, decodedMeal.strIngredient3, decodedMeal.strIngredient4, decodedMeal.strIngredient5, decodedMeal.strIngredient6, decodedMeal.strIngredient7, decodedMeal.strIngredient8, decodedMeal.strIngredient9, decodedMeal.strIngredient10, decodedMeal.strIngredient11, decodedMeal.strIngredient12, decodedMeal.strIngredient13, decodedMeal.strIngredient14, decodedMeal.strIngredient15, decodedMeal.strIngredient16, decodedMeal.strIngredient17, decodedMeal.strIngredient18, decodedMeal.strIngredient19, decodedMeal.strIngredient20]
            
            var ingredients = [Ingredient]()
            for ingredient in mealIngredients {
                if ingredient != nil && ingredient != "" {
                    let name = ingredient.unsafelyUnwrapped.lowercased()
                    /// differentiation between veggie and non-veggie ingredients in decoding level
                    let veggie = VeggieTrackerModel.veggieList.contains(where: {veggie in
                        (name.contains(veggie) || veggie.contains(name)) && name != "egg"
                    })
                    let newIngredient = Ingredient(name: name, veggie: veggie)
                    if (!ingredients.contains(newIngredient)){
                        ingredients.append(newIngredient)
                    }
                }
            }
            returnMeals.append(Meal(UUID(), ingredients: ingredients, name: decodedMeal.strMeal, imageUrl: decodedMeal.strMealThumb, tips: decodedMeal.strInstructions))
        }
        return returnMeals
    }
    /// Function to return list of meals that contain a search ingredient
    public func getMealsByIngredient(ingredient: String) async throws -> [Meal] {
        /// URL to get meal by ingredient
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)") else {
            throw VeggieServiceError.missingURL}
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            logger.log("Failed to fetch data from API")
            throw VeggieServiceError.failedFetch
        }
        let decodedMeals = try JSONDecoder().decode(Meals.self, from: data)
        let result = decodedMeals.meals
        var meals = [Meal]()
        do {
            try await meals = getMealsById(meals: result)
        } catch {
            logger.log("Error happened while getting meals from API")
        }
        return meals
    }
}
