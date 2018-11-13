//
//  ViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let profileButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 39, height: 39))
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = main
        
        
        setNavigationBar()
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    
    //MARK:- Private Methods
    
    private func setNavigationBar() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileButton)
//        navigationController?.navigationBar.barTintColor = .clear
//        navigationController?.navigationBar.tintColor = .white
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
    }
    
    private func setViews() {
        view.addSubview(newOrderButton)
        view.addSubview(logoImageView)
        view.addSubview(profileButton)
        
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
        profileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        
    }
    //MARK:- Button Actions
    
    @objc private func newOrderButtonPressed() {
        let checkLocationVC = CheckLocationViewController()
        navigationController?.pushViewController(checkLocationVC, animated: true)
    }
    
}

