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
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(title)
        
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -35).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.widthAnchor, constant: -35).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(withName name: String, image: UIImage){
        imageView.image = image
        title.text = name
    }
}
