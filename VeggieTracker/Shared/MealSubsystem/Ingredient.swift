//
//  Veggie.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation


public struct Ingredient: Codable {
    public var id: UUID?
    public var name: String
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

