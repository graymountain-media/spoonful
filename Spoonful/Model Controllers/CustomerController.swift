//
//  CustomerController.swift
//  Spoonful
//
//  Created by Jake Gray on 10/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import Firebase

class CustomerController {
    
    static let shared = CustomerController()
    
    var currentCustomer: Customer?
    
    func createNewCustomer(withUser user: User, firstName: String, lastName: String) {
        let customerID = UUID().uuidString
        
        let newCustomer = Customer(user: user, customerId: customerID, firstName: firstName, lastName: lastName)
        
        CustomerController.shared.currentCustomer = newCustomer
        
        FirebaseController.shared.add(customer: newCustomer)
    }
    
    func updateCurrentCustomer(withUser user: User) {
        let customerID = FirebaseController.shared.getCustomerId(forUser: user)
        
        let currentCustomer = Customer(user: user, customerId: customerID)
        
        CustomerController.shared.currentCustomer = currentCustomer
    }
    
    
}
