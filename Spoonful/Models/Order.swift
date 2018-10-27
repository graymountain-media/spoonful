//
//  Order.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

class Order {
    let bowl: Bowl
    let cereal: Cereal
    let milk: Milk
    
    init(bowl: Bowl, cereal: Cereal, milk: Milk) {
        self.bowl = bowl
        self.cereal = cereal
        self.milk = milk
    }
}
