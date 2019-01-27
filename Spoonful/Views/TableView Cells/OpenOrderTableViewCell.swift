//
//  OpenOrderTableViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 1/18/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OpenOrderTableViewCell: UITableViewCell {
    
    let cerealNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    override func layoutSubviews() {
        self.addSubview(cerealNameLabel)
        self.addSubview(dateLabel)
        
        cerealNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        cerealNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        cerealNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: cerealNameLabel.bottomAnchor, constant: 4).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
    
    func updateCellWith(name: String, date: String) {
        cerealNameLabel.text = name
        dateLabel.text = date
    }

}
