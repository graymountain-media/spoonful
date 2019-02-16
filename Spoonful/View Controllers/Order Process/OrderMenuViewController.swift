//
//  OrderMenuViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/3/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OrderMenuViewController: UIViewController {
    
    let menuCellID = "MenuCell"
    let cellID = "CellID"
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "New Order"
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Create your own bowl or choose from our delicious pre-made combinations"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = darktwo
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let customizeTitleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "CREATE YOUR OWN"
        label.textAlignment = .center
        return label
    }()
    

    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Order"
        view.backgroundColor = main
        
        menuTableView.register(OrderMenuTableViewCell.self, forCellReuseIdentifier: menuCellID)
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        setupViews()
    }
    
    //MARK:- Private Methods
    
    private func setupViews() {
        view.addSubview(instructionLabel)
        view.addSubview(menuTableView)
        
        instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        menuTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        menuTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        menuTableView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 16).isActive = true
        menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
}

extension OrderMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Products.cocktails.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
                return UITableViewCell()
            }
            
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.white.cgColor
            cell.backgroundColor = lightOne
            cell.addSubview(customizeTitleLabel)
            
            customizeTitleLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            customizeTitleLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            customizeTitleLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: menuCellID) as? OrderMenuTableViewCell else {
                return UITableViewCell()
            }
            let cocktail = Products.cocktails[indexPath.row - 1]
            cell.updateCellWith(cereals: cocktail.cereals, title: cocktail.name, price: cocktail.price)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 150
        } else {
            return 250
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let newOrderVC = NewOrderViewController()
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(newOrderVC, animated: true)
        } else {
            let cereals = Products.cocktails[indexPath.row - 1].cereals
            OrderController.shared.currentOrder.cereals = cereals
            OrderController.shared.currentOrder.total = Products.cocktails[indexPath.row - 1].price
            let milkChoiceVC = MilkChoiceViewController()
            navigationController?.pushViewController(milkChoiceVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
