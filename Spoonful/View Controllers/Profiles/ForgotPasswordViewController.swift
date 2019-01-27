//
//  ForgotPasswordViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/16/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
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
        label.text = "Forgot Password"
        label.font = titleFont.withSize(36)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: LoginTextField = {
        let textField = LoginTextField()
        textField.placeholder = "Email Address"
        textField.setIcon(withName: "email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var submitButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Submit", for: .normal)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeX"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicatior = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicatior.hidesWhenStopped = true
        indicatior.translatesAutoresizingMaskIntoConstraints = false
        return indicatior
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        setupView()
    }
    
    private func setupView() {
        view.addSubview(emailTextField)
        view.addSubview(titleLabel)
        view.addSubview(cancelButton)
        view.addSubview(submitButton)
        view.addSubview(messageView)
        messageView.addSubview(messageLabel)
        
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
        
        messageView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8).isActive = true
        messageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: messageView.topAnchor, constant: 8).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: messageView.leadingAnchor, constant: 16).isActive = true
        messageLabel.trailingAnchor.constraint(equalTo: messageView.trailingAnchor, constant: -16).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: messageView.bottomAnchor, constant: 8).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
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
    
    // MARK: - Button Actions
    
    @objc private func submitButtonPressed() {
        guard let email = emailTextField.text, !email.isEmpty else {
            
            let alert = UIAlertController(title: "Missing Information", message: "No email entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            return
            
        }
        startActivityIndicator()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            self.stopActivityIndicator()
            if let error = error {
                DispatchQueue.main.async {
                    self.messageView.backgroundColor = .red
                    self.messageLabel.text = "Oops! We were not able to find an account with that email address. Please check the address entered and try again."
                    self.messageView.isHidden = false
                }
                return
            }
            DispatchQueue.main.async {
                self.messageView.backgroundColor = .green
                self.messageLabel.text = "Success! We will send a password reset link to that email address. Please allow up to 5-10 minutes for that email to deliver."
                self.messageView.isHidden = false
            }
        }
    }
    
    @objc private func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
