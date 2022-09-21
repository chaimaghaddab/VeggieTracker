//
//  Veggie.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation

/// A meal's ingredient
public struct Ingredient: Codable {
    /// Ingredient's ID
    public var id: UUID?
    /// Ingredient's name
    public var name: String
    /// Whether the ingredient is a vegetable
    public var veggie: Bool
    
    init (id: UUID? = nil, name: String, veggie: Bool) {
        self.id = id
        self.name = name
        self.veggie = veggie
    }
}

extension Ingredient: Equatable { }

extension Ingredient: Hashable { }

extension Ingredient: Identifiable { }

