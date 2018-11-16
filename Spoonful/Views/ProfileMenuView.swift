//
//  ProfileMenuView.swift
//  Spoonful
//
//  Created by Jake Gray on 11/13/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ProfileMenuView: UIView {

    let title: UILabel = {
        let label = UILabel()
        label.text = "Spoonful"
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = main
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Log in to Spoonful"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = main
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    let loginButton: ProfileMenuButton = {
//        let button = ProfileMenuButton()
//        button.titleLabel?.text = "Login"
//        button.imageView?.image = UIImage(named: "profile")
//        return button
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(subtitle)
//        self.addSubview(loginButton)
        self.backgroundColor = offWhite
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        title.topAnchor.constraint(equalTo: superview?.safeAreaLayoutGuide.topAnchor ?? self.topAnchor, constant: 8).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        subtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        subtitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
//        loginButton.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8).isActive = true
//        loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

}
