//
//  BowlCollectionViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 10/27/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class BowlCollectionViewCell: UICollectionViewCell {
    
    //Properties
    var isSmall = false

    //Objects
    let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bowl-filled"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 3
        
        self.addSubview(imageView)
        self.addSubview(title)
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(isSmall: Bool) {
        if isSmall {
            setSmall()
        } else {
            setLarge()
        }
    }
    private func setSmall(){
        
        imageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -50).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        imageView.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -4).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        title.text = "Small"
    }
    
    private func setLarge(){
        
        imageView.widthAnchor.constraint(equalTo: self.heightAnchor, constant: -35).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        imageView.bottomAnchor.constraint(equalTo: title.topAnchor, constant: -4).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        title.text = "Large (+$0.50)"
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
