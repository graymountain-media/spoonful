//
//  ViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    let profileCellId = "ProfileCell"
    var isLoggedIn = false
    
    var handle: AuthStateDidChangeListenerHandle?
    
    lazy var profileButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 39, height: 39))
        button.setImage(UIImage(named: "profileWhite"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileButtonPressed), for: .touchUpInside)
        return button
    }()
    
//    let profileMenu = ProfileMenuView()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var newOrderButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("New Order", for: .normal)
        button.addTarget(self, action: #selector(newOrderButtonPressed), for: .touchUpInside)
        return button
    }()
    
//    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
//        let recognizer = UITapGestureRecognizer()
//        recognizer.addTarget(self, action: #selector(dismissProfileMenu))
//        return recognizer
//    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = main
        CheckLocationManager.shared.locationAuthorizationDelegate = self
        
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        CheckLocationManager.shared.locationManager.startUpdatingLocation()
        updateCurrentUser()
        setAuthenticationHandler()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        CheckLocationManager.shared.locationManager.stopUpdatingLocation()
        
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    
    //MARK:- Private Methods
    
    private func setAuthenticationHandler() {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // What to do when auth changes
            self.isLoggedIn = user != nil
            
            if !self.isLoggedIn {
                CustomerController.shared.currentCustomer = nil
            } else {
                CustomerController.shared.updateCurrentCustomer(withUser: user!)
            }
            
            
        }
    }
    
    private func setViews() {
        view.addSubview(newOrderButton)
        view.addSubview(logoImageView)
        view.addSubview(profileButton)
//        view.addSubview(profileMenu)
//        view.bringSubviewToFront(profileMenu)
        
        newOrderButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        newOrderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        newOrderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        newOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        
        profileButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        profileButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
//        profileMenu.frame = CGRect(x: -self.view.frame.width/2, y: 0, width: self.view.frame.width/2, height: self.view.frame.height)
    }
    
    private func updateCurrentUser() {
        if let currentUser = Auth.auth().currentUser {
            FirebaseController.shared.getCustomerId(forUser: currentUser) { (custID) in
                let currentCustomer = Customer(user: currentUser, customerId: custID)
                
                print("CUST ID AFTER UPDATE: \(custID)")
                CustomerController.shared.currentCustomer = currentCustomer
            }
            
            
        } else {
            print("no current user")
            CustomerController.shared.currentCustomer = nil
        }
    }
    //MARK:- Button Actions
    
    @objc private func newOrderButtonPressed() {
        let checkLocationVC = CheckLocationViewController()
        checkLocationVC.delegate = self
        checkLocationVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        
        let hasSeenLocationMessage = UserDefaults.standard.bool(forKey: "hasSeenLocationMessage")
        
        if hasSeenLocationMessage {
            checkLocation()
        } else {
            self.present(checkLocationVC, animated: true) {
                print("Presentation complete")
                UserDefaults.standard.setValue(true, forKey: "hasSeenLocationMessage")
            }
            return 
        }
    }
    
    @objc private func profileButtonPressed() {
        
        if !isLoggedIn {
            let loginVC = LogInViewController()
            present(loginVC, animated: true, completion: nil)
        } else {
            let profileMenuVC = ProfileMenuViewController()
            navigationController?.pushViewController(profileMenuVC, animated: true)
        }
        
    }

    
    private func checkLocation() {
        
        var  inLocation = false
        
        inLocation = CheckLocationManager.shared.checkUserLocation()
        
        if inLocation {
            navigationController?.pushViewController(DeliveryDestinationViewController(), animated: true)
        } else {
            let alert = UIAlertController(title: "Not In Delivery Area", message: "We're sorry but you are not currently in the delivery area.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            
            alert.addAction(okayAction)
            
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}

//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: profileCellId, for: indexPath)
//
//        cell.textLabel?.text = "Login"
//        cell.imageView?.image = UIImage(named: "profile")
//        cell.textLabel?.textColor = .white
//        cell.backgroundColor = lightTwo
//
//        return cell
//    }
//}

extension MainViewController: CheckUserDelegate, LocationAuthorizationDelegate {
    func presentAlert(_ alert: UIAlertController) {
        print("I am going to present alert")
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension MainViewController: CheckLocationViewControllerDelegate {
    func checkLocationViewDismissed() {
        print("dismissed")
        checkLocation()
    }
    
}
