//
//  Cocktail.swift
//  Spoonful
//
//  Created by Jake Gray on 1/6/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class Cocktail {
    
    let name: String
    let cereals : [Cereal]
    let price: Double
    let image: UIImage
    
    init(name: String, cereals: [Cereal], price: Double, image: UIImage = UIImage()) {
        self.name = name
        self.cereals = cereals
        self.price = price
        self.image = image
    }
}
