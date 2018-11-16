//
//  Milk.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

struct Milk {
    enum MilkType: String {
        case whole = "Whole"
        case twoPercent = "2%"
        case skim = "Skim"
        case almond = "Almond"
        case soy = "Soy"
    }
    let type : MilkType
    let price: Double
    
    init(type: MilkType) {
        self.type = type
        if type == MilkType.almond ||  type == MilkType.soy{
            self.price = 0.50
        } else {
            self.price = 0.00
        }
        
    }
}
