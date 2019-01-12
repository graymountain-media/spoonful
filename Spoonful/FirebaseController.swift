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
    
    func getCustomerId(forUser user: User, completion: @escaping (String) -> Void)  {
        let userIdRef = ref.child("users").child(user.uid).child("customerID")
        userIdRef.observeSingleEvent(of: .value) { (snapshot) in
            print("USER ID IS: \(snapshot.value)")
            let value = snapshot.value as? String ?? ""
            completion(value)
        }
    }
}
