//
//  LogInViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 12/31/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {

    //MARK:- Views
    
    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = UIScreen.main.bounds
        blurView.isHidden = true
        blurView.alpha = 0
        return blurView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
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
    
    lazy var loginButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var newAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle( "New User?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = main
        button.addTarget(self, action: #selector(newAccountButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Forgot Password?", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = main
        button.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
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
        
        emailTextField.becomeFirstResponder()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    //MARK:- View Setup
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
        view.addSubview(forgotPasswordButton)
        
        view.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        
        cancelButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 2).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        forgotPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 8).isActive = true
        forgotPasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        newAccountButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 8).isActive = true
        newAccountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        newAccountButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        newAccountButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    private func startActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1
        }) { (_) in
            self.activityIndicator.startAnimating()
        }
    }
    
    private func stopActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            self.activityIndicator.stopAnimating()
            self.blurEffectView.alpha = 0
        }) { (_) in
            self.blurEffectView.isHidden = true
        }
    }
    
    //MARK:- Button Actions
    
    @objc private func loginButtonPressed() {
        view.endEditing(true)
        
        
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
        
        startActivityIndicator()
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            self.stopActivityIndicator()
            if let error = error {
                let alert = UIAlertController(title: "Error Logging In", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
                return
            }
            self.view.endEditing(true)
            self.dismiss(animated: true, completion: nil)

        }
        
    }
    
    @objc private func forgotPasswordButtonPressed() {
        self.view.endEditing(true)
        
        let forgotPasswordVC = ForgotPasswordViewController()
        present(forgotPasswordVC, animated: true, completion: nil)
    }
    
    @objc private func newAccountButtonPressed() {
        self.view.endEditing(true)
        
        let registerVC = RegisterViewController()
        present(registerVC, animated: true, completion: nil)
    }
    
    @objc private func cancelButtonPressed() {
        view.endEditing(true)
        self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
            loginButtonPressed()
        }
        
        return true
    }
}
