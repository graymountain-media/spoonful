//
//  ProfileMenuButton.swift
//  Spoonful
//
//  Created by Jake Gray on 11/13/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class ProfileMenuButton: UIButton {
    
    let separatorView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = lightTwo
        return view
    }()
    
    var topSeparator = UIView()
    var bottomSeparator = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.contentMode = .scaleAspectFit
        
        self.backgroundColor = .white
        
        topSeparator = separatorView.copy() as! UIView
        bottomSeparator = separatorView.copy() as! UIView
        
        self.addSubview(topSeparator)
        self.addSubview(bottomSeparator)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        imageView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        imageView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        imageView?.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        
        titleLabel?.leadingAnchor.constraint(equalTo: imageView?.trailingAnchor ?? self.leadingAnchor, constant: 4).isActive = true
        titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        titleLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        topSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topSeparator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        bottomSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
