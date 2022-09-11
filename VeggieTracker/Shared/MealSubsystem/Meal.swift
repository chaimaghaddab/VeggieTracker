//
//  Meal.swift
//  
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation
import SwiftUI

public class Meal: ObservableObject {
    public var id: UUID?
    public var ingredients: [Ingredient]
    public var name: String
    public var imageUrl: String?
    public var tips: String?
    
    
    public init(_ id: UUID? = nil, ingredients: [Ingredient], name: String, imageUrl: String? = "", tips: String? = "") {
        self.id = id
        self.ingredients = ingredients
        self.name = name
        self.imageUrl = imageUrl
        self.tips = tips
    }
    
    public var veggies: [Ingredient] {
        return self.ingredients.filter{
            $0.veggie == true
        }
    }
    
    public var grade: some View {
        HStack {
            ForEach(1 ..< (veggies.count)/2 + 1) { i in
                Image(systemName: "leaf.fill").foregroundColor(Color.green)
            }
        }
    }
    
}

extension Meal: CustomStringConvertible {
    public var description: String {
        "the meal \(name) contains the veggies: \(veggies)"
    }
}

extension Meal: Identifiable { }

extension Meal: Hashable {
    public static func == (lhs: Meal, rhs: Meal) -> Bool {
        return lhs.id == rhs.id
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageUrl)
        hasher.combine(tips)
        hasher.combine(id)
    }
}

