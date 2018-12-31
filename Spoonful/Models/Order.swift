//
//  Order.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Order {
    let cereals: [Cereal]
    let milk: Milk
    let total: Int
    let id: UUID
    let location: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    
    init(cereals: [Cereal], milk: Milk, location: String, firstName: String = "", lastName: String = "", phoneNumber: String = "") {
        self.cereals = cereals
        self.milk = milk
        self.total = 375
        self.id = UUID()
        self.location = location
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
