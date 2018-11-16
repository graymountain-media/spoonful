//
//  HighlightButton.swift
//  Spoonful
//
//  Created by Jake Gray on 11/7/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class HighlightButton: UIButton {
    var highlightColor = UIColor()
    var defaultColor = UIColor()
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.alpha = 0.5
                self.backgroundColor = highlightColor
            } else {
                self.backgroundColor = UIColor.clear
            }
        }
    }
    
}
