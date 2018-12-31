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
    
    let
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Button Actions
    
    @objc private func submitButtonPressed() {
        activityIndicator.startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.view.frame.origin.y = 0
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "Missing Information", message: "No email entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "Missing Information", message: "No password entered", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
            
            return
            
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
            self.activityIndicator.stopAnimating()
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
    
}
