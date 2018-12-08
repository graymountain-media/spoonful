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
        label.font = titleFont.withSize(28)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.text = "Log in to Spoonful"
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = lightTwo
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(subtitle)
        self.addSubview(tableView)
        self.backgroundColor = darkOne
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
        
        tableView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -32).isActive = true
    }

}
