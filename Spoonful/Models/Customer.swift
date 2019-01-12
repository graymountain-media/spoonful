//
//  Customer.swift
//  Spoonful
//
//  Created by Jake Gray on 10/22/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import Firebase

class Customer {
    let fireId: String
    var customerId: String
    let firstName: String
    let email: String
    let lastName: String
    let phoneNumber: String
    
    init(fireId: String, customerId: String, firstName: String, lastName: String, email: String, phoneNumber: String) {
        self.fireId = fireId
        self.customerId = customerId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
    }
    
    init(user: User, customerId: String, firstName: String, lastName: String) {
        
//        if let displayName = user.displayName?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true) {
//            if displayName.count > 1 {
//                self.firstName = String(displayName[0])
//                self.lastName = String(displayName[1])
//            } else if displayName.count == 1 {
//                self.firstName = String(displayName[0])
//                self.lastName = ""
//            } else {
//                self.firstName = ""
//                self.lastName = ""
//            }
//        } else {
//            self.firstName = ""
//            self.lastName = ""
//        }
        
        self.fireId = user.uid
        self.customerId = customerId
        self.firstName = firstName
        self.lastName = lastName
        self.email = user.email ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
    }
    
    init(user: User, customerId: String) {
        
        if let displayName = user.displayName?.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true) {
            if displayName.count > 1 {
                self.firstName = String(displayName[0])
                self.lastName = String(displayName[1])
            } else if displayName.count == 1 {
                self.firstName = String(displayName[0])
                self.lastName = ""
            } else {
                self.firstName = ""
                self.lastName = ""
            }
        } else {
            self.firstName = ""
            self.lastName = ""
        }
        
        self.fireId = user.uid
        self.customerId = customerId
        self.email = user.email ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
    }
}
