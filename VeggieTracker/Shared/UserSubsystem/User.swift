//
//  User.swift
//  
//
//  Created by Chaima Ghaddab on 11.04.22.
//

import Foundation
import os

public struct User {
    private enum Constants {
        static let userId = "userId"
        static let username = "username"
    }
    
    let logger = Logger(subsystem: "chaima.ghaddab.VeggieTracker", category: "User")
    public var id: UUID?
    public var username: String
    
    
    
    init(id: UUID? = nil, username: String, token: String? = nil) {
        self.id = id
        self.username = username
        logger.log("Started session for user \(username)")
    }
    
}
