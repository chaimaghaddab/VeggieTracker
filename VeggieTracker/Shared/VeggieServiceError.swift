//
//  VeggieServiceError.swift
//  VeggieTracker
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Combine
import Foundation


public enum VeggieServiceError: Error {
    case emptyListOfChildren
    case missingURL
    case failedFetch
    
    public var localizedDescription: String {
        switch self {
        case .emptyListOfChildren:
            return "The list of children is empty"
        case .missingURL:
            return "Missing URL, could not load API"
        case .failedFetch:
            return "Failed to load data from the API"
        }
    }
}

