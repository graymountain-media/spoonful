//
//  Mock.swift
//  Spoonful
//
//  Created by Jake Gray on 10/29/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class Mock{
    static let cereal = [Cereal(name: "Cheerios", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Frosted Flakes", image: UIImage(named: "mockLogo2") ?? UIImage()),
                         Cereal(name: "Reese's Puffs", image: UIImage(named: "mockLogo3") ?? UIImage()),
                         Cereal(name: "Fruit Loops", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Frosted Mini Wheats", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Cinnimon Toast Cruch", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Kix", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Fruity Pebels", image: UIImage(named: "mockLogo") ?? UIImage()),
                         Cereal(name: "Honeycomb", image: UIImage(named: "mockLogo") ?? UIImage())]
    
    static let milk = [Milk(type: .twoPercent), Milk(type: .whole), Milk(type: .fatFree), Milk(type: .almond), Milk(type: .soy)]
}
