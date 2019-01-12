//
//  CheckBox.swift
//  Spoonful
//
//  Created by Jake Gray on 1/2/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    var checkedImage = UIImage()
    var uncheckedImage = UIImage()
    var isChecked: Bool = false {
        didSet {
            changeState()
        }
    }
    
    convenience init(checkedImage: UIImage, uncheckedImage: UIImage) {
        self.init()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.checkedImage = checkedImage
        self.uncheckedImage = uncheckedImage
        
        self.setImage(uncheckedImage, for: .normal)
        
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    private func changeState() {
        if isChecked {
            self.setImage(checkedImage, for: .normal)
        } else {
            self.setImage(uncheckedImage, for: .normal)
        }
    }
    
    func tapped(){
        isChecked = !isChecked
    }
}
