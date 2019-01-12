//
//  Order.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Order {
    var cereals: [Cereal]
    var milk: Milk?
    var total: Double
    let id: UUID
    var location: DeliveryLocation?
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var canText = true
    
    init(){
        self.cereals = []
        self.total = 0
        self.id = UUID()
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
    }
    
    init(cereals: [Cereal], milk: Milk, location: DeliveryLocation, firstName: String = "", lastName: String = "", phoneNumber: String = "") {
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
