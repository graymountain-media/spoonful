//
//  MilkCollectionViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 10/27/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class MilkCollectionViewCell: UICollectionViewCell {
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 56)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        
        self.layer.cornerRadius = 7
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        title.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(withTitle title: String) {
        self.title.text = title
    }
}
