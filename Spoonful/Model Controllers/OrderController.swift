//
//  OrderController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/3/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation


class OrderController {
    
    static let shared = OrderController()
    
    var currentOrder: Order
    
    init() {
        self.currentOrder = Order()
    }
    
    func resetOrder() {
        self.currentOrder = Order()
    }
}
