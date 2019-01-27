//
//  OrderDetailViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/18/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    lazy var orderFulfilledButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Order Fulfilled", for: .normal)
        button.backgroundDefaultColor = .green
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(orderFulfilledButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelOrderButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Cancel Order", for: .normal)
        button.backgroundDefaultColor = .red
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelOrderButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var rows: [OrderDetailRow] = []
    var order: Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupOrderInformation()
        setupRows()
        setupButtons()
    }
    
    private func setupOrderInformation() {
        guard let order = order, let location = order.location, let milk = order.milk else {
            return
        }
        
        let id = order.id
        createRow("ID", id)
        
        let dateOrdered = order.dateOrdered
        createRow("Date Ordered", dateOrdered)
        
        let cerealNames = order.cereals.compactMap({$0.name}).joined(separator: " + ")
        createRow("Cereals", cerealNames, lightOne)
        
        let milkName = milk.type.rawValue
        createRow("Milk", milkName, lightOne)
        
        let name = "\(order.firstName) \(order.lastName)"
        createRow("Name", name)
        
        let phoneNumber = order.phoneNumber
        createRow("Phone Number", phoneNumber)
        
        let building = location.building
        createRow("Building", building)
        
        let room = {
            return location.room == "" ?  "N/A" : location.room
        }()
        createRow("Room", room)
        
        let specialNotes = {
            return location.specialNotes == "" ?  "N/A" : location.specialNotes
        }()
        createRow("Special Notes", specialNotes)
        
        let canText = order.canText
        createRow("Can Text", String(canText))
        
        let isTestOrder = order.isTestOrder
        createRow("Is Test Order", String(isTestOrder))
        
    }
    
    private func setupRows() {
        for i in 0...(rows.count - 1) {
            let row = rows[i]
            view.addSubview(row)
            var lastRow = rows[i]
            if i <= 0 {
                row.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            } else {
                lastRow = rows[i-1]
                row.topAnchor.constraint(equalTo: lastRow.bottomAnchor).isActive = true
            }
            row.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            row.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
        }
    }
    
    private func setupButtons() {
        view.addSubview(cancelOrderButton)
        view.addSubview(orderFulfilledButton)
        
        cancelOrderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        cancelOrderButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8).isActive = true
        cancelOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        cancelOrderButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        orderFulfilledButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        orderFulfilledButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8).isActive = true
        orderFulfilledButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        orderFulfilledButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func createRow(_ title: String, _ detail: String, _ backgroundColor: UIColor = .clear) {
        let newRow = OrderDetailRow(title: title, detail: detail)
        newRow.backgroundColor = backgroundColor
        rows.append(newRow)
    }
   
    // MARK: - Button Actions
    
    @objc private func orderFulfilledButtonPressed() {
        guard let order = order else {
            return
        }
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you would like to fulfill this order?", preferredStyle: .alert)
        
        let fulfillAction = UIAlertAction(title: "Fulfill", style: .default) { (_) in
            FirebaseController.shared.complete(order: order) { (complete) in
                if complete {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        alert.addAction(fulfillAction)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func cancelOrderButtonPressed() {
        guard let order = order else {
            return
        }
    
        let alert = UIAlertController(title: "Are you sure?", message: "Are you sure you would like to cancel this order?", preferredStyle: .alert)
        
        let fulfillAction = UIAlertAction(title: "Cancel Order", style: .destructive) { (_) in
            FirebaseController.shared.cancel(order: order) { (complete) in
                if complete {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        alert.addAction(fulfillAction)
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
