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
    
    func  createNewCustomer(withUser user: User, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
        let customerID = ""

        let newCustomer = Customer(user: user, sandboxCustomerID: customerID, prodCustomerID: customerID, firstName: firstName, lastName: lastName)
        
        CustomerController.shared.currentCustomer = newCustomer
        
        BraintreeController.shared.createProductionBraintreeCustomer(withCustomer: newCustomer) { (responseString) in
            print("Creating braintree customer")
            if let customerID = responseString {
                print("production CUSTOMER ID: \(customerID)")
                newCustomer.prodCustomerID = customerID
                BraintreeController.shared.createSandboxBraintreeCustomer(withCustomer: newCustomer, completion: { (responseString) in
                    if let customerID = responseString {
                        print("production CUSTOMER ID: \(customerID)")
                        newCustomer.sandboxCustomerID = customerID
                        FirebaseController.shared.add(customer: newCustomer)
                        completion(true)
                        return
                    }
                    completion(false)
                    return
                })
            }
            completion(false)
            return
        }
        
        
    }
    
    func updateCurrentCustomer(withUser user: User) {
        var prodCustomerID = ""
        var sandboxCustomerID = ""
        FirebaseController.shared.getProductionCustomerId(forUser: user) { (custID) in
            prodCustomerID = custID
            
            FirebaseController.shared.getSandboxCustomerId(forUser: user, completion: { (custID) in
                sandboxCustomerID = custID
                
                let customer = Customer(user: user, sandboxCustomerID: sandboxCustomerID, prodCustomerID: prodCustomerID)
                CustomerController.shared.currentCustomer = customer
            })
        }
        
        
    }
    
    
}
