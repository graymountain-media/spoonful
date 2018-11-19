//
//  UserInputRow.swift
//  Spoonful
//
//  Created by Jake Gray on 11/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class UserInputRow: UIView {

    var title: String = "" {
        didSet{
            titleLabel.text = title.uppercased()
        }
    }
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var isInvalid = false {
        didSet{
            checkValidity()
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = titleFont.withSize(20)
        label.textColor = main
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.textAlignment = .right
        field.backgroundColor = .white
        field.layer.cornerRadius = 5
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 0
        field.textColor = main
        return field
    }()
    
    convenience init(title: String, placeholder: String, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        
        self.title = title
        self.placeholder = placeholder
        
        self.backgroundColor = lightOne
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(titleLabel)
        self.addSubview(textField)
    }
    
    override func layoutSubviews() {
        textField.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: textField.leadingAnchor, constant: -4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
    }
    
    private func checkValidity() {
        if self.isInvalid {
            titleLabel.textColor = .red
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1
        } else {
            titleLabel.textColor = main
            self.layer.borderWidth = 0
        }
    }

}
