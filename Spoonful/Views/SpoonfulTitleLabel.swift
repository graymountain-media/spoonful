//
//  SpoonfulTitleLabel.swift
//  Spoonful
//
//  Created by Jake Gray on 1/1/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class SpoonfulTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = titleFont.withSize(28)
        self.textColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.adjustsFontSizeToFitWidth = true
        self.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
