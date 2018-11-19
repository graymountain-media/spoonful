//
//  SelectionCollectionViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 11/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {
    var title: String = "" {
        didSet{
            titleLabel.text = title
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = titleFont.withSize(48)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    func update(withTitle title: String){
        self.title = title
    }
}
