//
//  FirebaseController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/1/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    static let shared = FirebaseController()
    
    func add(customer: Customer) {
        let userRef = ref.child("users").child(customer.fireId)
        
        let values = ["customerID" : customer.customerId]
        
        userRef.updateChildValues(values)
    }
    
    func getCustomerId(forUser user: User) -> String {
        let userIdRef = ref.child("users").child(user.uid).child("customerID")
        var userId = ""
        userIdRef.observeSingleEvent(of: .value) { (snapshot) in
            if let value = snapshot.value as? String {
                userId = value
            }
        }
        return userId
    }
}
