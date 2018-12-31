//
//  CerealCollectionViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 10/27/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CerealCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .green
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(title)
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(withName name: String, image: UIImage){
        imageView.image = image
        title.text = name
    }
}
