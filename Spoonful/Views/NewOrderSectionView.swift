//
//  NewOrderSectionView.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class NewOrderSectionView: UIView {
    var isCurrentSection = false
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
