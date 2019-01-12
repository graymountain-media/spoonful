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
    
    func createNewCustomer(withUser user: User, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        let customerID = ""
        
        let newCustomer = Customer(user: user, customerId: customerID, firstName: firstName, lastName: lastName)
        
        CustomerController.shared.currentCustomer = newCustomer
        
        BraintreeController.shared.createBraintreeCustomer(withCustomer: newCustomer) { (responseString) in
            print("Creating braintree customer")
            if let customerID = responseString {
                newCustomer.customerId = customerID
                completion(true)
                return
            }
            completion(false)
            return
        }
        
        
    }
    
    func updateCurrentCustomer(withUser user: User) {
        FirebaseController.shared.getCustomerId(forUser: user) { (custID) in
            let currentCustomer = Customer(user: user, customerId: custID)
            
            CustomerController.shared.currentCustomer = currentCustomer
        }
        
        
    }
    
    
}
