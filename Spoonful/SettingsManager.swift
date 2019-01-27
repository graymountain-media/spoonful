//
//  SettingsManager.swift
//  Spoonful
//
//  Created by Jake Gray on 1/25/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    
    var isProduction = true
    
    var tokenizationKey = ""
    var baseURL = productionBaseURL
    
    init() {
        tokenizationKey = productionTokenizationKey
        baseURL = productionBaseURL
    }
    
    func changeState() {
        isProduction = !isProduction
        
        if isProduction {
            baseURL = productionBaseURL
            tokenizationKey = productionTokenizationKey
        } else {
            baseURL = sandboxBaseURL
            tokenizationKey = sandBoxTokenizationKey
        }
    }
    
}
