//
//  Cereal.swift
//  Spoonful
//
//  Created by Jake Gray on 10/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

struct Cereal: Equatable {
    let name: String
    let price: Double
    let image: UIImage
    
    init(name: String, image: UIImage, price: Double = 0.00) {
        self.name = name
        self.image = image
        self.price = price
    }
}
