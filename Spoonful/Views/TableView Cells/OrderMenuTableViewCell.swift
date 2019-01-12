//
//  MenuTableViewCell.swift
//  Spoonful
//
//  Created by Jake Gray on 1/3/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OrderMenuTableViewCell: UITableViewCell {
    
    let contentWrapper: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let firstCerealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let secondCerealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let plusLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "+"
        label.textAlignment = .center
        label.font = titleFont.withSize(46)
        return label
    }()
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = ""
        label.font = titleFont.withSize(18)
        return label
    }()
    
    let subTitleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = ""
        label.font = titleFont.withSize(10)
        return label
    }()
    
    let titleBackground: UIView = {
        let view = UIView()
        view.backgroundColor = lightTwo
        view.alpha = 0.7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var cerealStackView = UIStackView()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        
        self.backgroundColor = .clear
        
        self.addSubview(contentWrapper)
        contentWrapper.addSubview(firstCerealImage)
        contentWrapper.addSubview(titleBackground)
        contentWrapper.addSubview(titleLabel)
        
        contentWrapper.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
        contentWrapper.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2).isActive = true
        contentWrapper.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentWrapper.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        setupStackView()
        
        cerealStackView.topAnchor.constraint(equalTo: contentWrapper.topAnchor).isActive = true
        cerealStackView.bottomAnchor.constraint(equalTo: titleBackground.topAnchor).isActive = true
        cerealStackView.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 50).isActive = true
        cerealStackView.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -50).isActive = true
        
        titleBackground.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor).isActive = true
        titleBackground.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor).isActive = true
        titleBackground.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor).isActive = true
        titleBackground.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: titleBackground.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor).isActive = true
    }
    
    private func setupStackView() {
        cerealStackView = UIStackView(arrangedSubviews: [firstCerealImage,plusLabel,secondCerealImage])
        cerealStackView.axis = .horizontal
        cerealStackView.distribution = .fillEqually
        cerealStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(cerealStackView)
    }
    
    override func prepareForReuse() {
        firstCerealImage.image = nil
        titleLabel.text = ""
    }
    
    func updateCellWith(cereals: [Cereal], title: String) {
        firstCerealImage.image = cereals[0].image
        secondCerealImage.image = cereals[1].image
        titleLabel.text = title
        subTitleLabel.text = "\(cereals[0].name) + \(cereals[1].name)"
    }

}
