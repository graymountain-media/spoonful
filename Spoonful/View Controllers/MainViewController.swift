//
//  ViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class MainViewController: UIViewController {
    
    let profileCellId = "ProfileCell"
    var isLoggedIn = false
    var isOpen = false {
        didSet{
            if isOpen {
                storeStatusLabel.text = "Store Is Open"
                storeStatusLabel.textColor = .green
            } else {
                storeStatusLabel.text = "Store Is Closed"
                storeStatusLabel.textColor = .red
            }
        }
    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    lazy var profileButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        button.setImage(UIImage(named: "profileWhite"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = main
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
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
    
    let cerealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spilledCereal")
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
    
    lazy var demoSwitchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let tripleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(demoSwitchTapped))
        tripleTapGestureRecognizer.numberOfTapsRequired = 5
        view.addGestureRecognizer(tripleTapGestureRecognizer)
        return view
    }()
    
    let demoLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "DEMO MODE"
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let storeStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.numberOfLines = 0
        label.text = "Store is Open"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
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
        checkStoreStatus { (isOpen) in
            if let isOpen = isOpen {
                self.isOpen = isOpen
            }
        }
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
        view.addSubview(cerealImageView)
        view.addSubview(logoImageView)
        view.addSubview(profileButton)
        view.addSubview(demoLabel)
        view.addSubview(demoSwitchView)
        view.addSubview(storeStatusLabel)
        
        storeStatusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        storeStatusLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        storeStatusLabel.bottomAnchor.constraint(equalTo: newOrderButton.topAnchor, constant: -8).isActive = true
        
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
        
        demoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        demoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        demoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
        demoSwitchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        demoSwitchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        demoSwitchView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        demoSwitchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
//        cerealImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
//        cerealImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cerealImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cerealImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    private func updateCurrentUser() {
        if let currentUser = Auth.auth().currentUser {
            var prodCustomerID = ""
            FirebaseController.shared.getProductionCustomerId(forUser: currentUser) { (custID) in
                prodCustomerID = custID
                FirebaseController.shared.getSandboxCustomerId(forUser: currentUser, completion: { (custID) in
                    let currentCustomer = Customer(user: currentUser, sandboxCustomerID: custID, prodCustomerID: prodCustomerID)
                    CustomerController.shared.currentCustomer = currentCustomer
                })
            }
        } else {
            print("no current user")
            CustomerController.shared.currentCustomer = nil
        }
    }
    
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
    //MARK:- Button Actions
    
    @objc private func newOrderButtonPressed() {
        if !SettingsManager.shared.isProduction {
            OrderController.shared.resetOrder()
            navigationController?.pushViewController(DeliveryDestinationViewController(), animated: true)
            return
        }
        DispatchQueue.main.async {
            self.checkStoreStatus({ (isOpen) in
                if let isOpen = isOpen, isOpen == false {
                    let alert = UIAlertController(title: "Shop Closed", message: "Sorry! We are currently closed and not doing deliveries at this time. Please try again later!", preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                    return
                } else {
                    OrderController.shared.resetOrder()
                    let checkLocationVC = CheckLocationViewController()
                    checkLocationVC.delegate = self
                    checkLocationVC.modalPresentationStyle = UIModalPresentationStyle.pageSheet
                    let hasSeenLocationMessage = UserDefaults.standard.bool(forKey: "hasSeenLocationMessage")
                    
                    if hasSeenLocationMessage {
                        self.checkLocation()
                    } else {
                        self.present(checkLocationVC, animated: true) {
                            print("Presentation complete")
                            UserDefaults.standard.setValue(true, forKey: "hasSeenLocationMessage")
                        }
                        return
                    }
                }
            })
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
    
    @objc private func demoSwitchTapped() {
        SettingsManager.shared.changeState()
        demoLabel.isHidden = SettingsManager.shared.isProduction
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
