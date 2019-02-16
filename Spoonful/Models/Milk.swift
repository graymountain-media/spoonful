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
    var imageName: String = ""
    
    init(type: MilkType) {
        self.type = type
        switch type {
        case .twoPercent:
            self.extraPrice = 0.00
            self.imageName = "twoPercent"
        case .fatFree:
            self.extraPrice = 0.00
            self.imageName = "fatFree"
        case .whole:
            self.extraPrice = 0.00
            self.imageName = "whole"
        case .almond:
            self.extraPrice = 1.80
            self.imageName = "almond"
        default:
            self.extraPrice = 0.00
        }
    }
}
