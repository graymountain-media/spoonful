//
//  ContactInfoViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/16/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class ContactInfoViewController: UIViewController {
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "How Can We Reach You?"
        return label
    }()
    
    let firstNameTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "First Name"
        textField.setIcon(withName: "profileBlack")
        return textField
    }()
    
    let lastNameTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Last Name"
        textField.setIcon(withName: "profileBlack")
        return textField
    }()
    
    let phoneNumberTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Phone Number"
        textField.setIcon(withName: "phoneBlack")
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    lazy var textConfimationCheckbox: CheckBox = {
        let checkbox = CheckBox(checkedImage: UIImage(named: "checkedWhite")!, uncheckedImage: UIImage(named: "uncheckedWhite")!)
        checkbox.isChecked = true
        checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
        return checkbox
    }()
    
    let textConfimationLabel: UILabel = {
        let label = UILabel()
        label.text = "I agree to be contacted via text/SMS message when my order arrives."
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let textToolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.isTranslucent = false
        toolbar.barTintColor = darkOne
        toolbar.tintColor = .white
        return toolbar
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contact Info"
        view.backgroundColor = main
        
        firstNameTextField.becomeFirstResponder()
        
        firstNameTextField.delegate = self
        firstNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        lastNameTextField.delegate = self
        lastNameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneNumberTextField.delegate = self
        phoneNumberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        setupToolbar()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        setupViews()
    }
    
    //MARK:- Private Methods
    
    private func setupToolbar() {
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolbarDoneButtonPressed))
        
        textToolBar.setItems([flexibleSpace, doneButton], animated: true)
        
        firstNameTextField.inputAccessoryView = textToolBar
        lastNameTextField.inputAccessoryView = textToolBar
        phoneNumberTextField.inputAccessoryView = textToolBar
    }
    
    
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(textConfimationCheckbox)
        view.addSubview(textConfimationLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 2).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        phoneNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 2).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textConfimationCheckbox.centerYAnchor.constraint(equalTo: textConfimationLabel.centerYAnchor).isActive = true
        textConfimationCheckbox.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        textConfimationCheckbox.widthAnchor.constraint(equalToConstant: 44).isActive = true
        textConfimationCheckbox.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        textConfimationLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 8).isActive = true
        textConfimationLabel.leadingAnchor.constraint(equalTo: textConfimationCheckbox.trailingAnchor, constant: 4).isActive = true
        textConfimationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        if let customer = CustomerController.shared.currentCustomer {
            firstNameTextField.text = customer.firstName
            lastNameTextField.text = customer.lastName
            phoneNumberTextField.text = customer.phoneNumber
            firstNameTextField.resignFirstResponder()
            phoneNumberTextField.becomeFirstResponder()
        }
    }
    
    private func validate(phoneNumber number: String) -> Bool {
        if number.isNumber && number.count == 10 {
            return true
        } else {
            return false
        }
        
    }
    
    @objc private func textFieldDidChange(textField : UITextField){
        if let first = firstNameTextField.text, !first.isEmpty, let last = lastNameTextField.text, !last.isEmpty, let phone = phoneNumberTextField.text, !phone.isEmpty {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    //MARK:- Button Actions
    
    @objc private func checkboxTapped() {
        textConfimationCheckbox.tapped()
    }
    
    @objc private func nextButtonPressed() {
        
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "No first name entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "No last name entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "No phone number entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let canText = textConfimationCheckbox.isChecked
        
        let isValidPhoneNumber = validate(phoneNumber: phoneNumber)
        
        if isValidPhoneNumber {
            let orderMenuVC = OrderMenuViewController()
            
            OrderController.shared.currentOrder.firstName = firstName
            OrderController.shared.currentOrder.lastName = lastName
            OrderController.shared.currentOrder.phoneNumber = phoneNumber
            OrderController.shared.currentOrder.canText = canText
            
            navigationController?.pushViewController(orderMenuVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Invalid Phone Number", message: "The phone number entered is not valid", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
            return
        }
        
    }
    
    @objc private func toolbarDoneButtonPressed() {
       view.endEditing(true)
    }
}

extension ContactInfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case firstNameTextField:
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            lastNameTextField.resignFirstResponder()
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            phoneNumberTextField.resignFirstResponder()
            nextButtonPressed()
        default:
            return true
        }
        
        return true
    }
}
