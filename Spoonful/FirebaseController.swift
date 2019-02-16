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
        
        let values: [String : Any] = [
            "sandboxCustomerID" : customer.sandboxCustomerID,
            "prodCustomerID" : customer.prodCustomerID,
            "isEmployee" : false
            ]
        
        userRef.updateChildValues(values)
    }
    
    func checkEmployeeStatus(withID id: String, completion: @escaping (Bool) -> Void) {
        ref.child("users").child(id).child("isEmployee").observeSingleEvent(of: .value) { (snapshot) in
            if let isEmployee = snapshot.value as? Bool {
                completion (isEmployee)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    
    func getProductionCustomerId(forUser user: User, completion: @escaping (String) -> Void)  {
        let userIdRef = ref.child("users").child(user.uid).child("prodCustomerID")
        userIdRef.observeSingleEvent(of: .value) { (snapshot) in
            print("USER ID IS: \(snapshot.value)")
            let value = snapshot.value as? String ?? ""
            completion(value)
        }
    }
    
    func getSandboxCustomerId(forUser user: User, completion: @escaping (String) -> Void)  {
        let userIdRef = ref.child("users").child(user.uid).child("sandboxCustomerID")
        userIdRef.observeSingleEvent(of: .value) { (snapshot) in
            print("USER ID IS: \(snapshot.value)")
            let value = snapshot.value as? String ?? ""
            completion(value)
        }
    }
    
    func send(order: Order, completion: @escaping(Bool) -> Void) {
        let orderRef = ref.child("orders").child("open").child(order.id)
        let cerealRef = orderRef.child("cereals")
        let locationRef = orderRef.child("location")
        guard let milk = order.milk, let location = order.location else {
            print("error sending item")
            completion(false)
            return
        }
        let values: [String : Any] = [
            "id" : order.id,
            "milk" : milk.type.rawValue,
            "total": String(order.total),
            "firstName" : order.firstName,
            "lastName" : order.lastName,
            "phoneNumber" : order.phoneNumber,
            "canText" : String(order.canText),
            "isComplete" : false,
            "dateOrdered" : order.dateOrdered,
            "isTestOrder" : order.isTestOrder
            ]
        let cerealValues = order.cereals.compactMap({$0.name})
        let locationValues = [
            "building" : location.building,
            "room" : location.room,
            "specialNotes" : location.specialNotes
        ]
        orderRef.updateChildValues(values)
        cerealRef.setValue(cerealValues)
        locationRef.updateChildValues(locationValues)
        completion(true)
        
    }
    
    func complete(order: Order, completion: @escaping(Bool) -> Void) {
        FirebaseController.shared.delete(order: order, from: "open")
        let completeOrderRef = ref.child("orders").child("complete").child(order.id)
        let cerealRef = completeOrderRef.child("cereals")
        let locationRef = completeOrderRef.child("location")
        guard let milk = order.milk, let location = order.location else {
            print("error sending item")
            completion(false)
            return
        }
        let values: [String : Any] = [
            "id" : order.id,
            "milk" : milk.type.rawValue,
            "total": String(order.total),
            "firstName" : order.firstName,
            "lastName" : order.lastName,
            "phoneNumber" : order.phoneNumber,
            "canText" : String(order.canText),
            "isComplete" : false,
            "dateOrdered" : order.dateOrdered,
            "isTestOrder" : order.isTestOrder
        ]
        let cerealValues = order.cereals.compactMap({$0.name})
        let locationValues = [
            "building" : location.building,
            "room" : location.room,
            "specialNotes" : location.specialNotes
        ]
        completeOrderRef.updateChildValues(values)
        cerealRef.setValue(cerealValues)
        locationRef.updateChildValues(locationValues)
        completion(true)
        
    }
    
    func cancel(order: Order, completion: @escaping(Bool) -> Void) {
        FirebaseController.shared.delete(order: order, from: "open")
        let cancelOrderRef = ref.child("orders").child("canceled").child(order.id)
        let cerealRef = cancelOrderRef.child("cereals")
        let locationRef = cancelOrderRef.child("location")
        guard let milk = order.milk, let location = order.location else {
            print("error sending item")
            completion(false)
            return
        }
        let values: [String : Any] = [
            "id" : order.id,
            "milk" : milk.type.rawValue,
            "total": String(order.total),
            "firstName" : order.firstName,
            "lastName" : order.lastName,
            "phoneNumber" : order.phoneNumber,
            "canText" : String(order.canText),
            "isComplete" : false,
            "dateOrdered" : order.dateOrdered,
            "isTestOrder" : order.isTestOrder
        ]
        let cerealValues = order.cereals.compactMap({$0.name})
        let locationValues = [
            "building" : location.building,
            "room" : location.room,
            "specialNotes" : location.specialNotes
        ]
        cancelOrderRef.updateChildValues(values)
        cerealRef.setValue(cerealValues)
        locationRef.updateChildValues(locationValues)
        completion(true)
        
    }
    
    func delete(order: Order, from branch: String) {
        let deleteOrderRef = ref.child("orders").child(branch).child(order.id)
        deleteOrderRef.removeValue()
    }
    
    func fetchCurrentOrders(_ completion: @escaping([Order]?) -> Void) {
        ref.child("orders").child("open").observeSingleEvent(of: .value) { (snapshot) in
            guard let ordersDict = snapshot.value as? [String: Any] else {
                print("cannot get orders dict")
                completion(nil)
                return
            }
            var openOrders: [Order] = []
            for order in ordersDict {
                if let orderDict = order.value as? [String: Any], let newOrder = Order(dict: orderDict) {
                    print("NEW ORDER DICT: ", orderDict)
                    openOrders.append(newOrder)
                } else {
                    print("cannot get new order")
                }
            }
            
            completion(openOrders)
            return
            
        }
    }
    
    func checkStoreStatus(completion: @escaping (Bool?, String?) -> Void) {
        ref.child("store").child("isOpen").observeSingleEvent(of: .value) { (snapshot) in
            if let isOpen = snapshot.value as? Bool {
                completion(isOpen, nil)
                return
            } else {
                completion(nil, "Could not get store status")
                return
            }
        }
    }
    
    func updateStoreStatus(completion: @escaping (Bool?, String?) -> Void) {
        FirebaseController.shared.checkStoreStatus { (isOpen, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let isOpen = isOpen {
                let newStatus = !isOpen
                ref.child("store").child("isOpen").setValue(newStatus)
                completion(newStatus, nil)
                return
            }
            
        }
    }
//    var cereals: [Cereal]
//    var milk: Milk?
//    var total: Double
//    let id: UUID
//    var location: DeliveryLocation?
//    var firstName: String
//    var lastName: String
//    var phoneNumber: String
//    var canText = true
}
