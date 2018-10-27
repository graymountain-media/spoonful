//
//  Cereal.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct Cereal {
    let name: String
    let price: Double
    
    init(name: String, price: Double = 0.00) {
        self.name = name
        self.price = price
    }
}
