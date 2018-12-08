//
//  ContactInfoViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

protocol ContactInfoDelegate: class {
    func contactInfoEntered(firstName: String, lastName: String, phoneNumber: String)
}

class ContactInfoTableViewController: UITableViewController {
    
    weak var delegate: ContactInfoDelegate?
    let cellID = "ContactCell"
    
    //MARK:- Objects
    
    let firstNameRow: UserInputRow = {
        let row = UserInputRow(title: "First Name", placeholder: "John")
        row.backgroundColor = .white
        return row
    }()
    
    let lastNameRow: UserInputRow = {
        let row = UserInputRow(title: "Last Name", placeholder: "Doe")
        row.backgroundColor = .white
        return row
    }()
    
    let phoneNumberRow: UserInputRow = {
        let row = UserInputRow(title: "Phone Number", placeholder: "1234567890")
        row.backgroundColor = .white
        row.textField.keyboardType = .decimalPad
        return row
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    //MARK:- Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = offWhite
        self.title = "Contact Information"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
        
        
        setupRows()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        firstNameRow.textField.becomeFirstResponder()
    }
    
    //MARK:- View Setup
    
    private func setupRows() {
        
        view.addSubview(firstNameRow)
        view.addSubview(lastNameRow)
        view.addSubview(phoneNumberRow)
        
        firstNameRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        firstNameRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        firstNameRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        firstNameRow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        firstNameRow.textField.delegate = self
        
        lastNameRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        lastNameRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        lastNameRow.topAnchor.constraint(equalTo: firstNameRow.bottomAnchor).isActive = true
        lastNameRow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lastNameRow.textField.delegate = self
        
        phoneNumberRow.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        phoneNumberRow.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        phoneNumberRow.topAnchor.constraint(equalTo: lastNameRow.bottomAnchor).isActive = true
        phoneNumberRow.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneNumberRow.textField.delegate = self
    }
    
    private func validatePhoneNumber(number: String) -> Bool {
        if number.count != 10 {
            return false
        }
        
        if !number.isNumber {
            return false
        }
        
        return true
        
    }
    
    //MARK:- TableViewDelegate
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let customRow: UserInputRow
        
        switch indexPath.row {
        case 0:
            customRow = firstNameRow
        case 1:
            customRow = lastNameRow
        case 2:
            customRow = phoneNumberRow
        default:
            cell.addSubview(errorLabel)
            cell.backgroundColor = offWhite
            
            errorLabel.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            errorLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
            errorLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
            errorLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            
            return cell
        }
        
        cell.contentView.addSubview(customRow)
        customRow.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
        customRow.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
        customRow.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
        customRow.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    //MARK:- Actions
    
    @objc private func saveButtonPressed(){
        firstNameRow.isInvalid = false
        lastNameRow.isInvalid = false
        phoneNumberRow.isInvalid = false
        
        guard let firstName = firstNameRow.textField.text, !firstName.isEmpty else {
            errorLabel.text = "Missing First Name"
            firstNameRow.isInvalid = true
            return
        }
        guard let lastName = lastNameRow.textField.text, !lastName.isEmpty else {
            errorLabel.text = "Missing Last Name"
            lastNameRow.isInvalid = true
            return
        }
        guard let phoneNumber = phoneNumberRow.textField.text, !phoneNumber.isEmpty else {
            errorLabel.text = "Missing Phone Number"
            phoneNumberRow.isInvalid = true
            return
        }
        
        if !validatePhoneNumber(number: phoneNumber){
            errorLabel.text = "Invalid Phone Number"
            phoneNumberRow.isInvalid = true
            return
        }
        errorLabel.text = ""
        view.endEditing(true)
        delegate?.contactInfoEntered(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ContactInfoTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameRow.textField:
            firstNameRow.textField.resignFirstResponder()
            lastNameRow.textField.becomeFirstResponder()
        case lastNameRow.textField:
            lastNameRow.textField.resignFirstResponder()
            phoneNumberRow.textField.becomeFirstResponder()
        default:
            saveButtonPressed()
        }
        return true
    }
}
