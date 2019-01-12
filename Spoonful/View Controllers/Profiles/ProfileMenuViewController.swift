//
//  ProfileMenuViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/13/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class ProfileMenuViewController: UIViewController {

    var customer: Customer?
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
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
    
    lazy var logOutButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Log Out", for: .normal)
        button.backgroundDefaultColor = .red
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
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
            
            titleLabel.text = "Hello, \(currentCustomer.firstName)!"
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- View Setup
    
    private func setupViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(logOutButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: logOutButton.topAnchor, constant: -8).isActive = true
    }
    
    //MARK:- Button Actions
    
    @objc private func createCustomerButtonPressed(){
        if let customer = customer {
            BraintreeController.shared.createBraintreeCustomer(withCustomer: customer) { (responseString) in
                print(responseString)
            }
        }
    }
    
    @objc private func logOutButtonPressed() {
        try? Auth.auth().signOut()
        navigationController?.popViewController(animated: true)
    }

}
