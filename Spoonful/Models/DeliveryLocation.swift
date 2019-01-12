//
//  DeliveryLocation.swift
//  Spoonful
//
//  Created by Jake Gray on 1/3/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation

struct DeliveryLocation {
    let building: String
    let room: String
    let specialNotes: String
    
    init(building: String, room: String, specialNotes: String) {
        self.building = building
        self.room = room
        self.specialNotes = specialNotes
    }
}
