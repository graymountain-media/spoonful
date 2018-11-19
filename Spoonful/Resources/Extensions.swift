//
//  Extensions.swift
//  Spoonful
//
//  Created by Jake Gray on 11/19/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
}
