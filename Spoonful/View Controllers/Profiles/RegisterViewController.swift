//
//  RegisterViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 12/31/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = titleFont.withSize(36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeX"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
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
    
    let emailTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Email Address"
        textField.setIcon(withName: "email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Password"
        textField.setIcon(withName: "passwordLock")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordConfirmationTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Confirm Password"
        textField.setIcon(withName: "passwordLock")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var registerButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var existingAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Already have an account?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = main
        button.addTarget(self, action: #selector(existingAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicatior = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicatior.hidesWhenStopped = true
        indicatior.translatesAutoresizingMaskIntoConstraints = false
        return indicatior
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Log In"
        
        view.backgroundColor = main
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        firstNameTextField.becomeFirstResponder()
        
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- View Setup
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordConfirmationTextField)
        view.addSubview(registerButton)
        view.addSubview(existingAccountButton)
        view.addSubview(activityIndicator)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        firstNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        firstNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 1).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        lastNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 2).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordConfirmationTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1).isActive = true
        passwordConfirmationTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        passwordConfirmationTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        passwordConfirmationTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registerButton.topAnchor.constraint(equalTo: passwordConfirmationTextField.bottomAnchor, constant: 32).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        existingAccountButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 8).isActive = true
        existingAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        existingAccountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        existingAccountButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    //MARK:- Button Actions

    @objc private func registerButtonPressed() {
        
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
        guard let email = emailTextField.text, !email.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "No email entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)

            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "No password entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)

            return
        }
        guard let confirmPassword = passwordConfirmationTextField.text, !confirmPassword.isEmpty else {
            let alert = UIAlertController(title: "Missing Information", message: "Please confirm your password", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)

            return
        }

        let results = validatePassword(password: password, confirmPassword: confirmPassword)

        if results.0 == false {
            let alert = UIAlertController(title: "Invalid Password", message: results.1, preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)

            return
        }

        activityIndicator.startAnimating()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in

            if let error = error {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                let alert = UIAlertController(title: "Oops! Something went wrong!", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)

                return
            }

            //Successful
            if let user = result?.user {
                self.view.endEditing(true)
                CustomerController.shared.createNewCustomer(withUser: user, firstName: firstName, lastName: lastName, completion: { (resultString) in
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "\(firstName) \(lastName)"
                    changeRequest?.commitChanges(completion: { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    })
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                })
            }
        }

    }

    @objc private func existingAccountButtonPressed(){
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)    }

    // MARK: - Methods
    private func validatePassword(password: String, confirmPassword: String) -> (Bool, String) {

        if password.count < 8 {
            return (false, "Password must be at least 8 characters long")
        }

        if password != confirmPassword {
            return (false, "Passwords do not match")
        }

        return (true, "")
    }
    
    @objc private func cancelButtonPressed() {
        view.endEditing(true)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }

}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordConfirmationTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
            registerButtonPressed()
        }
        
        return true
    }
}
