//
//  Location.swift
//  Spoonful
//
//  Created by Jake Gray on 1/1/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation

struct LocationsJSONDict: Codable {
    let locations: [Location]
}

struct Location: Codable {
    let name: String
    let rooms: [String]
    
    init(name: String, rooms: [String]) {
        self.name = name
        self.rooms = rooms
    }
}
