//
//  OrderDetailRow.swift
//  Spoonful
//
//  Created by Jake Gray on 1/18/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OrderDetailRow: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let bottomDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0.5
        return view
    }()
    
    convenience init(title: String, detail: String) {
        self.init()
        titleLabel.text = title
        detailLabel.text = detail
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
    }
    
    private func setupView() {
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(bottomDividerView)
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 4 - 4).isActive = true
        
        detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        detailLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: -self.frame.width / 4 + 4).isActive = true
        
        bottomDividerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        bottomDividerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomDividerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomDividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.heightAnchor.constraint(equalTo: detailLabel.heightAnchor, constant: 8).isActive = true
    }
}
