//
//  UserInputRow.swift
//  Spoonful
//
//  Created by Jake Gray on 11/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class UserInputRow: UIView {
//    
//    var isInvalid = false {
//        didSet{
//            checkValidity()
//        }
//    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = titleFont.withSize(20)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let field = UITextField()
        field.textAlignment = .right
        field.backgroundColor = lightTwo
        field.layer.cornerRadius = 5
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.layer.borderWidth = 0
        field.textColor = .white
        field.autocorrectionType = .no
        return field
    }()
    
    convenience init(title: String, placeholder: String, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        
        self.titleLabel.text = title
        self.textField.placeholder = placeholder
        
        self.backgroundColor = lightTwo
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
    
//    private func checkValidity() {
//        if self.isInvalid {
//            titleLabel.textColor = .red
//            self.layer.borderColor = UIColor.red.cgColor
//            self.layer.borderWidth = 1
//        } else {
//            titleLabel.textColor = main
//            self.layer.borderWidth = 0
//        }
//    }

}
