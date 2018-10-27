//
//  Milk.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct Milk {
    enum MilkType: Double {
        case whole
        case twoPercent
        case skim
        case almond = 0.50
    }
    let type : MilkType
    let price: Double
    
    init(type: MilkType, price: Double) {
        self.type = type
        self.price = price 
    }
}
