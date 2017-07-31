//
//  Location.swift
//  SpyFall
//
//  Created by Daniel Meechan on 31/07/2017.
//  Copyright © 2017 Rogue Studios. All rights reserved.
//

import Foundation

class Location {
    var name: String
    var roles: [String]
    
    static var shared = [Location]()
    
    init() {
        name = "EMPTY LOCATION"
        roles = [String]()
        
    }
    
    init(name: String, roles: [String]) {
        self.name = name
        self.roles = roles
        
    }
    
    static func getSampleLocations() {
        var locations = [Location]()
        locations.append(Location(name: "location1", roles: ["apple", "bee", "can"]))
        locations.append(Location(name: "location2", roles: ["dog", "cat", "fox"]))
        locations.append(Location(name: "location3", roles: ["coke", "pepsi", "dr pepper"]))
        
        Location.shared = locations
        
    }
    
}
