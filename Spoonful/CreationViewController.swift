//
//  ViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/26/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    let profileButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 39, height: 39))
        button.setImage(UIImage(named: "profile"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var newOrderButton: UIButton = {
        let button = UIButton()
        button.setTitle("New Order", for: .normal)
        button.setTitleColor(main, for: .normal)
        button.addTarget(self, action: #selector(newOrderButtonPressed), for: .touchUpInside)
        button.addTarget(self, action: #selector(newOrderButtonTouchDown), for: .touchDown)
        button.backgroundColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = main
        
        
        setNavigationBar()
        setViews()
    }
    
    //MARK:- Private Methods
    
    private func setNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: profileButton)
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    private func setViews() {
        view.addSubview(newOrderButton)
        view.addSubview(logoImageView)
        
        newOrderButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        newOrderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        newOrderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        newOrderButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -30).isActive = true
        
    }
    //MARK:- Button Actions
    
    @objc private func newOrderButtonPressed() {
        newOrderButton.backgroundColor = .white
        print("hi")
    }
    
    @objc private func newOrderButtonTouchDown() {
        newOrderButton.backgroundColor = .gray
       
    }
    
}

