//
//  LoginTextField.swift
//  Spoonful
//
//  Created by Jake Gray on 12/31/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    let customLeftView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 66, height: 50))
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.autocorrectionType = .no
        
        leftViewMode = .always
        leftView = customLeftView
        customLeftView.addSubview(iconImageView)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: customLeftView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: customLeftView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIcon(withName name: String){
        let icon = UIImage(named: name)
        iconImageView.image = icon
    }
}
