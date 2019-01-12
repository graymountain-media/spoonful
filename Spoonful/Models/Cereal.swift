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
    let isPremium: Bool
    let image: UIImage
    
    init(name: String, image: UIImage, isPremium: Bool = false) {
        self.name = name
        self.image = image
        self.isPremium = isPremium
    }
}
