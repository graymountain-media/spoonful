//
//  CheckoutRow.swift
//  Spoonful
//
//  Created by Jake Gray on 11/3/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CheckoutRow: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PAYMENT"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = titleFont.withSize(20)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .white)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let backgroundButton: HighlightButton = {
        let button = HighlightButton()
        button.defaultColor = lightOne
        button.highlightColor = lightTwo
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.4
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    var onTap: () -> () = {print("Tapped")}
    
    var loading = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.loading {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.detailLabel.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.detailLabel.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    var title: String = "Payment" {
        didSet{
            titleLabel.text = title.uppercased()
        }
    }
    
    var detail: String = "" {
        didSet{
            detailLabel.text = detail
        }
    }
    
    convenience init(title: String, detail: String, tappable: Bool = true, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        
        self.title = title
        self.detail = detail
        
        self.backgroundColor = lightOne
        
        self.addSubview(backgroundButton)
        backgroundButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        if !tappable{
            backgroundButton.isUserInteractionEnabled = false
            
        }
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(activityIndicator)
        self.addSubview(topSeparator)
        
        self.titleLabel.text = title
        self.detailLabel.text = detail
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        topSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topSeparator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        backgroundButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backgroundButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        backgroundButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        detailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        
        activityIndicator.leadingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.bringSubviewToFront(backgroundButton)
    }
    
    @objc func didTap() {
        self.onTap()
    }
    
    
}
