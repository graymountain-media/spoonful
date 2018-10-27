//
//  Bowl.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct Bowl {
    
    enum BowlSize: Double {
        case small = 2.00
        case large = 2.50
    }
    
    let size: BowlSize
    let price: Double
    
    init(size: BowlSize) {
        self.size = size
        self.price = size.rawValue
    }
}
