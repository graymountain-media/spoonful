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
        case fatFree = "Fat-Free"
        case almond = "Almond"
        case soy = "Soy"
    }
    let type : MilkType
    let extraPrice: Double
    
    init(type: MilkType) {
        self.type = type
        if type == MilkType.almond{
            self.extraPrice = 1.80
        } else if type == MilkType.soy {
            self.extraPrice = 1.25
        } else {
            self.extraPrice = 0.00
        }
        
    }
}
