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
    var id: String
    var location: DeliveryLocation?
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var canText = true
    var isTestOrder = false
    var dateOrdered = ""
    
    init(){
        self.cereals = []
        self.total = 0
        self.id = UUID().uuidString
        self.firstName = ""
        self.lastName = ""
        self.phoneNumber = ""
    }
    
    init(cereals: [Cereal], milk: Milk, location: DeliveryLocation, firstName: String = "", lastName: String = "", phoneNumber: String = "") {
        self.cereals = cereals
        self.milk = milk
        self.total = 375
        self.id = UUID().uuidString
        self.location = location
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
    
    init?(dict: [String: Any]){
        if let total = dict["total"] as? String,
            let id = dict["id"] as? String,
            let firstName = dict["firstName"] as? String,
            let lastName = dict["lastName"] as? String,
            let phoneNumber = dict["phoneNumber"] as? String,
            let canText = dict["canText"] as? String,
            let isTestOrder = dict["isTestOrder"] as? Bool,
            let dateOrdered = dict["dateOrdered"] as? String {
                self.total = Double(total) ?? 0.00
                self.id = id
                self.firstName = firstName
                self.lastName = lastName
                self.phoneNumber = phoneNumber
                self.canText = canText == "true" ? true : false
                self.isTestOrder = isTestOrder
                self.dateOrdered = dateOrdered
        } else {
            print("Issue with a parameter")
            return nil
        }
        
        guard let cereals = dict["cereals"] as? [String] else {
            print("Issue with cereals")
            return nil
        }
        
        guard let location = dict["location"] as? [String: Any] else {
            print("Issue with location")
            return nil
        }
        
        guard let milk = dict["milk"] as? String else {
            print("Issue with milk")
            return nil
        }
        
        self.cereals = []
        for cereal in cereals {
            for prodCereal in Products.cereal {
                if cereal == prodCereal.name {
                    self.cereals.append(prodCereal)
                }
            }
        }
        if self.cereals.count < 1 {
            print("no cereals here")
            return nil
        }
        
        switch milk {
        case "Whole":
            self.milk = Milk(type: .whole)
        case "2%":
            self.milk = Milk(type: .twoPercent)
        case "Fat-Free":
            self.milk = Milk(type: .fatFree)
        case "Almond":
            self.milk = Milk(type: .almond)
        default:
            print("could not identify milk")
            return nil
        }
        print("LOCATION:", location)
        if let building = location["building"] as? String, !building.isEmpty {
            let room = location["room"] as? String ?? ""
            let specialNotes = location["specialNotes"] as? String ?? ""
            let newLocation = DeliveryLocation(building: building, room: room, specialNotes: specialNotes)
            self.location = newLocation
        } else {
            print("What building?")
            return nil
        }
    }
}
