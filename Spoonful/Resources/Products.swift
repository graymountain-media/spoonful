//
//  Products.swift
//  Spoonful
//
//  Created by Jake Gray on 12/15/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class Products {
    
    static let appleJacks = Cereal(name: "Apple Jacks", image: UIImage(named: "AppleJacks") ?? UIImage(), isPremium: true)
    
    static let captainCruch = Cereal(name: "Captain Crunch Berries", image: UIImage(named: "CaptainCrunch") ?? UIImage())
   
    static let cheerios = Cereal(name: "Cheerios", image: UIImage(named: "Cheerios") ?? UIImage())
    
    static let cinnamonToastCrunch = Cereal(name: "Cinnamon Toast Crunch", image: UIImage(named: "CinnamonToastCrunch") ?? UIImage())
    
    static let cocoPuffs = Cereal(name: "Coco Puffs", image: UIImage(named: "CocoPuffs") ?? UIImage())
    
    static let cookieCrisp = Cereal(name: "Cookie Crisp", image: UIImage(named: "CookieCrisp") ?? UIImage(), isPremium: true)
    
    static let fruitLoops = Cereal(name: "Froot Loops", image: UIImage(named: "FrootLoops") ?? UIImage())
    
    static let frostedFlakes = Cereal(name: "Frosted Flakes", image: UIImage(named: "FrostedFlakes") ?? UIImage())
    
    static let fruityPebbles = Cereal(name: "Fruity Pebbles", image: UIImage(named: "FruityPebbles") ?? UIImage())
    
    static let honeyBunchesOfOats = Cereal(name: "Honey Bunches Of Oats", image: UIImage(named: "HoneyBunchesOfOats") ?? UIImage())
    
    static let honeyComb = Cereal(name: "Honey Comb", image: UIImage(named: "HoneyComb") ?? UIImage())
    
    static let honeyNutCheerios = Cereal(name: "Honey Nut Cheerios", image: UIImage(named: "HoneyNutCheerios") ?? UIImage())
    
    static let luckyCharms = Cereal(name: "Lucky Charms", image: UIImage(named: "LuckyCharms") ?? UIImage())
    
    static let frostedMiniWheats = Cereal(name: "Frosted Mini Wheats", image: UIImage(named: "MiniWheats") ?? UIImage())
    
    static let multigrainCheerios = Cereal(name: "MultiGrain Cheerios", image: UIImage(named: "MultiGrainCheerios") ?? UIImage(), isPremium: true)
    
    static let oreoOs = Cereal(name: "Oreo O's", image: UIImage(named: "OreoOs") ?? UIImage(), isPremium: true)
    
    static let raisinBran = Cereal(name: "Raisin Bran", image: UIImage(named: "RaisinBran") ?? UIImage())
    
    static let reesesPuffs = Cereal(name: "Reese's Puffs", image: UIImage(named: "ReesesPuffs") ?? UIImage())
    
    static let specialK = Cereal(name: "Special K Red Berries", image: UIImage(named: "SpecialK") ?? UIImage(), isPremium: true)
    
    static let trix = Cereal(name: "Trix", image: UIImage(named: "Trix") ?? UIImage(), isPremium: true)
    
    static let cereal: [Cereal] = [Products.appleJacks, Products.captainCruch, Products.cheerios, Products.cinnamonToastCrunch, Products.cocoPuffs, Products.cookieCrisp, Products.fruitLoops, Products.frostedFlakes, Products.fruityPebbles, Products.honeyBunchesOfOats, Products.honeyComb, Products.honeyNutCheerios, Products.luckyCharms, Products.frostedFlakes, Products.multigrainCheerios, Products.oreoOs, Products.raisinBran, Products.reesesPuffs, Products.specialK, Products.trix]
    
    static let cocktails = [Cocktail(name: "SNICKERDOODLE", cereals: [Products.cookieCrisp, Products.cinnamonToastCrunch], price: 3.75),
                                Cocktail(name: "THE IMPOSTER", cereals: [Products.cheerios, Products.fruitLoops], price: 3.50),
                                Cocktail(name: "THE PUFFS", cereals: [Products.reesesPuffs, Products.cocoPuffs], price: 3.50),
                                Cocktail(name: "THE RAINBOW", cereals: [Products.fruitLoops, Products.fruityPebbles], price: 3.50),
                                Cocktail(name: "HONEY POT", cereals: [Products.honeyNutCheerios, Products.honeyComb], price: 3.50),
                                Cocktail(name: "HAPPY HEART", cereals: [Products.cheerios, Products.specialK], price: 3.75)]
    
    static let milk = [Milk(type: .twoPercent), Milk(type: .whole), Milk(type: .fatFree), Milk(type: .almond)]
}
