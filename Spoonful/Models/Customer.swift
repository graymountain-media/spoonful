//
//  Customer.swift
//  Spoonful
//
//  Created by Jake Gray on 10/22/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Customer {
    let id: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    init(id: String, firstName: String, lastName: String, phoneNumber: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
    }
}
