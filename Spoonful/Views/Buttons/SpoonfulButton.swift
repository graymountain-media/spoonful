//
//  SpoonfulButton.swift
//  Spoonful
//
//  Created by Jake Gray on 11/9/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SpoonfulButton: UIButton {
    
    var backgroundDefaultColor: UIColor = .white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(main, for: .normal)
        self.backgroundColor = .white
        self.tintColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.backgroundColor = .lightGray
            } else {
                self.backgroundColor = backgroundDefaultColor
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet{
            if isEnabled {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 1
                    self.backgroundColor = self.backgroundDefaultColor
                }
                
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0.5
                    self.backgroundColor = .lightGray
                }
            }
        }
    }
    
}
