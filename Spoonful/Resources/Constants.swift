//
//  Constants.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

//MARK:- Colors

let main = UIColor(red: 0, green: 198/255, blue: 244/255, alpha: 1)
let darkOne = UIColor(red: 0, green: 180/255, blue: 222/255, alpha: 1)
let darktwo = UIColor(red: 0, green: 163/255, blue: 200/255, alpha: 1)
let lightOne = UIColor(red: 23/255, green: 203/255, blue: 245/255, alpha: 1)
let lightTwo = UIColor(red: 46/255, green: 208/255, blue: 246/255, alpha: 1)
let offWhite = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)

let titleFont = UIFont(name: "PeaceSans", size: 24)!

let checkoutGreen = UIColor(red: 0, green: 244/255, blue: 46/255, alpha: 1)


//MARK:- Firebase

let ref = Database.database().reference()

//MARK:- Stripe

//let baseURL = URL(string: "http://localhost:3003")!
let sandboxBaseURL = URL(string: "https://spoonful-app.herokuapp.com")!
let productionBaseURL = URL(string: "https://spoonful-app-production.herokuapp.com")!
//let appleMerchantID = "merchant.com.Spoonful"
let companyName = "Spoonful"

// Tokenization Key
let sandBoxTokenizationKey = "sandbox_xswpggg8_k2z7jdk8znqf6y3p"
let productionTokenizationKey = "production_ybvvh9wn_scqgmw88rq4dc3w6"

//MARK: Location Path
let locationDataPath = Bundle.main.path(forResource: "Locations", ofType: "json")

