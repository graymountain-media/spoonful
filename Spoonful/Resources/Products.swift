//
//  Products.swift
//  Spoonful
//
//  Created by Jake Gray on 12/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class Products {
    
    static let cereal = [Cereal(name: "Apple Jacks", image: UIImage(named: "AppleJacks") ?? UIImage(), extraPrice: 0.25),
                         
                         Cereal(name: "Captain Crunch Berries", image: UIImage(named: "CaptainCrunch") ?? UIImage()),
                         
                         Cereal(name: "Cheerios", image: UIImage(named: "Cheerios") ?? UIImage()),
                         
                         Cereal(name: "Cinnamon Toast Crunch", image: UIImage(named: "CinnamonToastCrunch") ?? UIImage()),
                         
                         Cereal(name: "Coco Puffs", image: UIImage(named: "CocoPuffs") ?? UIImage()),
                         
                         Cereal(name: "Cookie Crisp", image: UIImage(named: "CookieCrisp") ?? UIImage(), extraPrice: 0.25),
                         
                         Cereal(name: "Froot Loops", image: UIImage(named: "FrootLoops") ?? UIImage()),
                         
                         Cereal(name: "Frosted Flakes", image: UIImage(named: "FrostedFlakes") ?? UIImage()),
                         
                         Cereal(name: "Fruity Pebbles", image: UIImage(named: "FruityPebbles") ?? UIImage()),
                         
                         Cereal(name: "Honey Bunches Of Oats", image: UIImage(named: "HoneyBunchesOfOats") ?? UIImage()),
                         
                         Cereal(name: "Honey Comb", image: UIImage(named: "HoneyComb") ?? UIImage()),
                         
                         Cereal(name: "Honey Nut Cheerios", image: UIImage(named: "HoneyNutCheerios") ?? UIImage()),
                         
                         Cereal(name: "Lucky Charms", image: UIImage(named: "LuckyCharms") ?? UIImage()),
                         
                         Cereal(name: "Frosted Mini Wheats", image: UIImage(named: "MiniWheats") ?? UIImage()),
                         
                         Cereal(name: "MultiGrain Cheerios", image: UIImage(named: "MultiGrainCheerios") ?? UIImage(), extraPrice: 0.25),
                         
                         Cereal(name: "Oreo O's", image: UIImage(named: "OreoOs") ?? UIImage(), extraPrice: 0.25),
                         
                         Cereal(name: "Raisin Bran", image: UIImage(named: "RaisinBran") ?? UIImage()),
                         
                         Cereal(name: "Reese's Puffs", image: UIImage(named: "ReesesPuffs") ?? UIImage()),
                         
                         Cereal(name: "Special K Red Berries", image: UIImage(named: "SpecialK") ?? UIImage(), extraPrice: 0.25),
                         
                         Cereal(name: "Trix", image: UIImage(named: "Trix") ?? UIImage(), extraPrice: 0.25)]
    
    static let milk = [Milk(type: .twoPercent), Milk(type: .whole), Milk(type: .skim), Milk(type: .almond), Milk(type: .soy)]
}
