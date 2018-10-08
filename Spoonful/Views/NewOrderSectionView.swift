//
//  NewOrderSectionView.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class NewOrderSectionView: UIView {
    var isCurrentSection = false
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var nextButton: UIButton = {
//        let button = UIButton()
//        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle("Next >", for: .normal)
//        button.backgroundColor = main
//        button.setTitleColor(.white, for: .normal)
//        return button
//    }()
    
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
        self.backgroundColor = main
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0.5
        
        setConstraints()
    }
    
    private func setConstraints() {
        self.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        
        self.addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
//        self.contentView.addSubview(nextButton)
//        nextButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
//        nextButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
//        nextButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
//        nextButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4).isActive = true
    }
    
//    @objc private func nextButtonPressed(firstHeight: NSLayoutConstraint?, secondHeight: NSLayoutConstraint?, firstTop: NSLayoutConstraint?, secondTop: NSLayoutConstraint?) {
//        firstHeight?.isActive = false
//        secondHeight?.isActive = true
//
//        firstTop?.isActive = false
//        secondTop?.isActive = true
//
//        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.contentView.alpha = 0
//            self.layoutIfNeeded()
//        }) { (_) in
//            self.contentView.isHidden = true
//        }
//    }
    
    
    
    
}
