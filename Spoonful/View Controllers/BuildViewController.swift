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
    
    var milkChoiceFirstHeight: NSLayoutConstraint?
    var milkChoiceSecondHeight: NSLayoutConstraint?
    
    var milkChoiceFirstTop: NSLayoutConstraint?
    var milkChoiceSecondTop: NSLayoutConstraint?
    
    let yourOrderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Bowl Size View Properties
    let bowlSizeView: NewOrderSectionView = {
        let view = NewOrderSectionView()
        view.setupView()
        view.isCurrentSection = true
        return view
    }()
    
    lazy var bowlSizeNextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(bowlSizeNextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal)
        button.backgroundColor = main
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //Cereal View Properties
    let cerealChoiceView: NewOrderSectionView = {
        let view = NewOrderSectionView()
        view.setupView()
        return view
    }()
    
    lazy var cerealChoiceNextButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cerealChoiceNextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next >", for: .normal)
        button.backgroundColor = main
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    //Milk Choice View
    let milkChoiceView: NewOrderSectionView = {
        let view = NewOrderSectionView()
        view.setupView()
        return view
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(cerealChoiceNextButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Checkout", for: .normal)
        button.backgroundColor = checkoutGreen
        button.setTitleColor(.white, for: .normal)
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
        setTapGestureRecognizers()
    }
    
    //MARK:- Private Methods
    
    private func setupViews() {
        view.addSubview(yourOrderView)
        setupYourOrderView()
        
        view.addSubview(bowlSizeView)
        setupBowlSizeView()
        
        view.addSubview(cerealChoiceView)
        setupCerealChoiceView()
        
        view.addSubview(milkChoiceView)
        setupMilkChoiceView()
        
    }
    
    private func setupYourOrderView() {
        yourOrderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        yourOrderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        yourOrderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        yourOrderView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.text = "Your Order:"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        yourOrderView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: yourOrderView.topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: yourOrderView.leadingAnchor, constant: 4).isActive = true
        
    }
    
    private func setupBowlSizeView() {
        
        bowlSizeView.titleLabel.text = "Step 1: Pick Your Bowl Size"
        
        bowlSizeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bowlSizeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bowlSizeView.topAnchor.constraint(equalTo: yourOrderView.bottomAnchor).isActive = true
        
        bowlSizeFirstHeight = bowlSizeView.heightAnchor.constraint(equalToConstant: 150)
        bowlSizeFirstHeight?.isActive = true
        
        bowlSizeSecondHeight = bowlSizeView.heightAnchor.constraint(equalToConstant: 44)
        bowlSizeSecondHeight?.isActive = false
        
        bowlSizeView.contentView.addSubview(bowlSizeNextButton)
        
//        stepOneLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        
        
        bowlSizeNextButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        bowlSizeNextButton.leadingAnchor.constraint(equalTo: bowlSizeView.contentView.leadingAnchor, constant: 8).isActive = true
        bowlSizeNextButton.trailingAnchor.constraint(equalTo: bowlSizeView.contentView.trailingAnchor, constant: -8).isActive = true
        bowlSizeNextButton.bottomAnchor.constraint(equalTo: bowlSizeView.contentView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func setupCerealChoiceView() {
        cerealChoiceView.titleLabel.text = "Step 2: Choose Your Cereal (Limit 2)"
        
        cerealChoiceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cerealChoiceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        ////
        
        cerealChoiceFirstTop = cerealChoiceView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        cerealChoiceFirstTop?.isActive = true
        
        cerealChoiceSecondTop = cerealChoiceView.topAnchor.constraint(equalTo: bowlSizeView.bottomAnchor)
        cerealChoiceSecondTop?.isActive = false
        
        ////
        
        cerealChoiceFirstHeight = cerealChoiceView.heightAnchor.constraint(equalToConstant: 150)
        cerealChoiceFirstHeight?.isActive = true
        
        cerealChoiceSecondHeight = cerealChoiceView.heightAnchor.constraint(equalToConstant: 44)
        cerealChoiceSecondHeight?.isActive = false
        
        cerealChoiceView.contentView.addSubview(cerealChoiceNextButton)
        
        cerealChoiceNextButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        cerealChoiceNextButton.leadingAnchor.constraint(equalTo: cerealChoiceView.contentView.leadingAnchor, constant: 8).isActive = true
        cerealChoiceNextButton.trailingAnchor.constraint(equalTo: cerealChoiceView.contentView.trailingAnchor, constant: -8).isActive = true
        cerealChoiceNextButton.bottomAnchor.constraint(equalTo: cerealChoiceView.contentView.bottomAnchor, constant: -4).isActive = true
    }
    
    private func setupMilkChoiceView() {
        milkChoiceView.titleLabel.text = "Step 3: Choose Your Milk Type"
        
        milkChoiceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        milkChoiceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        ////
        
        milkChoiceFirstTop = milkChoiceView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        milkChoiceFirstTop?.isActive = true
        
        milkChoiceSecondTop = milkChoiceView.topAnchor.constraint(equalTo: cerealChoiceView.bottomAnchor)
        milkChoiceSecondTop?.isActive = false
        
        ////
        
        milkChoiceFirstHeight = milkChoiceView.heightAnchor.constraint(equalToConstant: 150)
        milkChoiceFirstHeight?.isActive = true
        
        milkChoiceSecondHeight = milkChoiceView.heightAnchor.constraint(equalToConstant: 44)
        milkChoiceSecondHeight?.isActive = false
    }
    
    private func viewTapped(_ tappedView: NewOrderSectionView) {
        
        if tappedView.isCurrentSection {
            switch tappedView {
            case bowlSizeView:
                bowlSizeFirstHeight?.isActive = true
                bowlSizeSecondHeight?.isActive = false
                
                cerealChoiceFirstHeight?.isActive = false
                cerealChoiceSecondHeight?.isActive = true
                
                milkChoiceFirstHeight?.isActive = false
                milkChoiceSecondHeight?.isActive = true
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bowlSizeView.contentView.alpha = 1
                    self.cerealChoiceView.contentView.alpha = 0
                    self.milkChoiceView.contentView.alpha = 0
                    self.view.layoutIfNeeded()
                }) { (_) in
                    self.bowlSizeView.contentView.isHidden = false
                    self.cerealChoiceView.contentView.isHidden = true
                    self.milkChoiceView.contentView.isHidden = true
                }
                
            case cerealChoiceView:
                bowlSizeFirstHeight?.isActive = false
                bowlSizeSecondHeight?.isActive = true
                
                cerealChoiceFirstHeight?.isActive = true
                cerealChoiceSecondHeight?.isActive = false
                
                milkChoiceFirstHeight?.isActive = false
                milkChoiceSecondHeight?.isActive = true
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bowlSizeView.contentView.alpha = 0
                    self.cerealChoiceView.contentView.alpha = 1
                    self.milkChoiceView.contentView.alpha = 0
                    self.view.layoutIfNeeded()
                }) { (_) in
                    self.bowlSizeView.contentView.isHidden = true
                    self.cerealChoiceView.contentView.isHidden = false
                    self.milkChoiceView.contentView.isHidden = true
                }
                
            case milkChoiceView:
                bowlSizeFirstHeight?.isActive = false
                bowlSizeSecondHeight?.isActive = true
                
                cerealChoiceFirstHeight?.isActive = false
                cerealChoiceSecondHeight?.isActive = true
                
                milkChoiceFirstHeight?.isActive = true
                milkChoiceSecondHeight?.isActive = false
                
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.bowlSizeView.contentView.alpha = 0
                    self.cerealChoiceView.contentView.alpha = 0
                    self.milkChoiceView.contentView.alpha = 1
                    self.view.layoutIfNeeded()
                }) { (_) in
                    self.bowlSizeView.contentView.isHidden = true
                    self.cerealChoiceView.contentView.isHidden = true
                    self.milkChoiceView.contentView.isHidden = false
                }
                
            default:
                print("Error: No tapped view")
            }
        }
    }
    
    //MARK: Tap Gesture Recognizers
    
    private func setTapGestureRecognizers() {
        let sizeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sizeViewTapped))
        let cerealTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cerealViewTapped))
        let milkTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(milkViewTapped))
        
        milkChoiceView.addGestureRecognizer(milkTapGestureRecognizer)
        cerealChoiceView.addGestureRecognizer(cerealTapGestureRecognizer)
        bowlSizeView.addGestureRecognizer(sizeTapGestureRecognizer)
    }
    
    //MARK:- Button Actions
    
    @objc private func bowlSizeNextButtonPressed() {
        bowlSizeFirstHeight?.isActive = false
        bowlSizeSecondHeight?.isActive = true
        
        cerealChoiceFirstTop?.isActive = false
        cerealChoiceSecondTop?.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.bowlSizeView.contentView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.bowlSizeView.contentView.isHidden = true
        }
    }
    
    @objc private func cerealChoiceNextButtonPressed() {
        cerealChoiceFirstHeight?.isActive = false
        cerealChoiceSecondHeight?.isActive = true
        
        milkChoiceFirstTop?.isActive = false
        milkChoiceSecondTop?.isActive = true
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.cerealChoiceView.contentView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (_) in
            self.cerealChoiceView.contentView.isHidden = true
        }
    }
    
    //MARK:- Tap Gesture Actions
    
    @objc private func sizeViewTapped(){
        print("Size tapped")
        viewTapped(bowlSizeView)
    }
    
    @objc private func cerealViewTapped(){
        print("cereal tapped")
        viewTapped(cerealChoiceView)
    }
    
    @objc private func milkViewTapped(){
        print("milk tapped")
        viewTapped(milkChoiceView)
    }

}
