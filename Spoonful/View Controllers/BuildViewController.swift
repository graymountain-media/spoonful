//
//  BuildViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class BuildViewController: UIViewController {
    
    //MARK:- Layout Properties
    var bowlSizeFirstHeight: NSLayoutConstraint?
    var bowlSizeSecondHeight: NSLayoutConstraint?
    
    var cerealChoiceFirstHeight: NSLayoutConstraint?
    var cerealChoiceSecondHeight: NSLayoutConstraint?
    
    var cerealChoiceFirstTop: NSLayoutConstraint?
    var cerealChoiceSecondTop: NSLayoutConstraint?
    
    let yourOrderView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let bowlSizeView: NewOrderSectionView = {
        let view = NewOrderSectionView()
        view.setupView()
        view.backgroundColor = .red
        view.isCurrentSection = true
        return view
    }()
    
    lazy var bowlSizeNextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(bowlSizeNextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal)
        button.backgroundColor = milkWhite
        button.setTitleColor(main, for: .normal)
        return button
    }()
    
    let cerealChoiceView: NewOrderSectionView = {
        let view = NewOrderSectionView()
        view.setupView()
        view.backgroundColor = .orange
        return view
    }()
    
    lazy var cerealChoiceNextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cerealChoiceNextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal)
        button.backgroundColor = milkWhite
        button.setTitleColor(main, for: .normal)
        return button
    }()

    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        
        self.title = "Build a Bowl"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        setupViews()
    }
    
    //MARK:- Private Methods
    
    private func setupViews() {
        view.addSubview(yourOrderView)
        setupYourOrderView()
        
        view.addSubview(bowlSizeView)
        setupBowlSizeView()
        
        view.addSubview(cerealChoiceView)
        setupCerealChoiceView()
        
    }
    
    private func setupYourOrderView() {
        yourOrderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        yourOrderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        yourOrderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        yourOrderView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = "Your Order:"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        yourOrderView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: yourOrderView.topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: yourOrderView.leadingAnchor, constant: 4).isActive = true
        
    }
    
    private func setupBowlSizeView() {
        bowlSizeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        bowlSizeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        bowlSizeView.topAnchor.constraint(equalTo: yourOrderView.bottomAnchor, constant: 8).isActive = true
        
        bowlSizeFirstHeight = bowlSizeView.heightAnchor.constraint(equalToConstant: 150)
        bowlSizeFirstHeight?.isActive = true
        
        bowlSizeSecondHeight = bowlSizeView.heightAnchor.constraint(equalToConstant: 40)
        bowlSizeSecondHeight?.isActive = false
        
        bowlSizeView.addSubview(bowlSizeNextButton)
        
        bowlSizeNextButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        bowlSizeNextButton.leadingAnchor.constraint(equalTo: bowlSizeView.leadingAnchor, constant: 8).isActive = true
        bowlSizeNextButton.trailingAnchor.constraint(equalTo: bowlSizeView.trailingAnchor, constant: -8).isActive = true
        bowlSizeNextButton.bottomAnchor.constraint(equalTo: bowlSizeView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func setupCerealChoiceView() {
        cerealChoiceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        cerealChoiceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        ////
        
        cerealChoiceFirstTop = cerealChoiceView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        cerealChoiceFirstTop?.isActive = true
        
        cerealChoiceSecondTop = cerealChoiceView.topAnchor.constraint(equalTo: bowlSizeView.bottomAnchor, constant: 8)
        cerealChoiceSecondTop?.isActive = false
        
        ////
        
        cerealChoiceFirstHeight = cerealChoiceView.heightAnchor.constraint(equalToConstant: 150)
        cerealChoiceFirstHeight?.isActive = true
        
        cerealChoiceSecondHeight = cerealChoiceView.heightAnchor.constraint(equalToConstant: 40)
        cerealChoiceSecondHeight?.isActive = true
    }
    
    //MARK:- Button Actions
    
    @objc private func bowlSizeNextButtonPressed() {
        bowlSizeFirstHeight?.isActive = false
        bowlSizeSecondHeight?.isActive = true
        
        cerealChoiceFirstTop?.isActive = false
        cerealChoiceSecondTop?.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func cerealChoiceNextButtonPressed() {
        cerealChoiceFirstHeight?.isActive = false
        cerealChoiceSecondHeight?.isActive = true
        
        cerealChoiceFirstTop?.isActive = false
        cerealChoiceSecondTop?.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}
