//
//  ProfileMenuViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/13/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging

class ProfileMenuViewController: UIViewController {

    var customer: Customer?
    var isOpen = false {
        didSet {
            if isOpen {
                self.openStoreButton.backgroundColor = .green
                self.openStoreButton.setTitle("Close Store", for: .normal)
            } else {
                self.openStoreButton.backgroundColor = .gray
                self.openStoreButton.setTitle("Open Store", for: .normal)
            }
        }
    }
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        return label
    }()
    
    let detailLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "More options coming soon!"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = lightTwo
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        return table
    }()
    
    lazy var ordersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Orders", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.isHidden = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var openStoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open Store", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .gray
        button.isHidden = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(openStoreButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = darkOne
        
        self.title = "My Profile"
        
        setupViews()
        
        if let currentCustomer = CustomerController.shared.currentCustomer   {
            customer = currentCustomer
            checkEmployeeStatus(forCustomer: currentCustomer)
            titleLabel.text = "Hello, \(currentCustomer.firstName)!"
           
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        checkStoreStatus { (isOpen) in
            if let isOpen = isOpen {
                self.isOpen = isOpen
            }
        }
    }
    
    //MARK:- View Setup
    
    private func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(logOutButton)
        view.addSubview(ordersButton)
        view.addSubview(detailLabel)
        view.addSubview(openStoreButton)
        
        detailLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        ordersButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        ordersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        ordersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        ordersButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        openStoreButton.topAnchor.constraint(equalTo: ordersButton.bottomAnchor, constant: 2).isActive = true
        openStoreButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        openStoreButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        openStoreButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func checkEmployeeStatus(forCustomer customer: Customer) {
        FirebaseController.shared.checkEmployeeStatus(withID: customer.fireId) { (isEmployee) in
            print("ISEmployee", isEmployee)
            if isEmployee {
                Messaging.messaging().subscribe(toTopic: "newOrders") { error in
                    print("Subscribed to newOrders")
                }
                DispatchQueue.main.async {
                    self.ordersButton.isEnabled = true
                    self.ordersButton.isHidden = false
                    self.openStoreButton.isEnabled = true
                    self.openStoreButton.isHidden = false
                    
                }
            }
        }
    }
    //MARK:- Button Actions
    
    @objc private func orderButtonPressed(){
        let orderListTVC = OrderListTableViewController()
        navigationController?.pushViewController(orderListTVC, animated: true)
    }
    
    @objc private func openStoreButtonPressed() {
        
        FirebaseController.shared.updateStoreStatus { (isOpen, error) in
            if let error = error {
                print(error)
            }
            
            if let isOpen = isOpen {
                if isOpen {
                    self.openStoreButton.backgroundColor = .green
                    self.openStoreButton.setTitle("Close Store", for: .normal)
                } else {
                    self.openStoreButton.backgroundColor = .gray
                    self.openStoreButton.setTitle("Open Store", for: .normal)
                }
            }
        }
        
    }
    
    @objc private func logOutButtonPressed() {
        try? Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Methods
    
    private func checkStoreStatus(_ completion: @escaping(Bool?) -> Void) {
        FirebaseController.shared.checkStoreStatus {(isOpen, errorString) in
            if let isOpen = isOpen {
                completion(isOpen)
                return
            }
            completion(false)
            return
        }
    }

}
