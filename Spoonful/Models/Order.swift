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
    let cereals: [Cereal]
    let milk: Milk
    let total: Int
    
    init(bowl: Bowl, cereals: [Cereal], milk: Milk) {
        self.bowl = bowl
        self.cereals = cereals
        self.milk = milk
        self.total = 500
    }
}
