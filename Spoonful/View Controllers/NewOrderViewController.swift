//
//  BuildViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    //MARK:- Properties
    let bowlCellId = "BowlCell"
    let cerealCellId = "CerealCell"
    let milkCellId = "MilkCell"
    
    
    lazy var activeSelectionTop: CGFloat = self.view.center.y - self.view.frame.width * 0.2
    lazy var discardOriginX: CGFloat = self.view.frame.width + 5
    
    var orderStage = 1
    
    //New Order Properties
    var bowl: Bowl?
    var selectedCereals: [Cereal] = []
    var milk: Milk?
    var order: Order?
    
    //MARK:- Objects
    
//    lazy var orderCerealSlot1Frame: CGRect = CGRect(x: yourOrderView.frame.origin.x + yourOrderView.frame.width * 0.33, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33, height: yourOrderView.frame.height / 2)
//
//    lazy var orderCerealSlot2Frame: CGRect = CGRect(x: yourOrderView.frame.origin.x + yourOrderView.frame.width * 0.33, y: yourOrderView.frame.origin.y + yourOrderView.frame.height / 2, width: yourOrderView.frame.width * 0.33, height: yourOrderView.frame.height / 2)
    
    
//    lazy var orderBowlSlot: CGRect = CGRect(x: yourOrderView.frame.origin.x, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33, height: yourOrderView.frame.height)
    let orderBowlSlotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    let orderCerealSlot1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    let orderCerealSlot2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    let orderMilkSlotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
//    lazy var orderMilkSlot: CGRect = CGRect(x: yourOrderView.frame.origin.x + yourOrderView.frame.width * 0.66 + 10, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33 - 10, height: yourOrderView.frame.height)
    
    
    let yourOrderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = darkOne
        return view
    }()
    
    let selectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = lightOne
        return view
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a Bowl Size"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yourOrderLabel : UILabel = {
        let label = UILabel()
        label.text = "Your Order:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bowlCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var cerealCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = main
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var milkCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = main
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
//    lazy var smallBowl: BowlSizeChoiceView = {
//        let view = BowlSizeChoiceView(frame: CGRect(x: self.view.center.x - self.view.frame.width * 0.4 - 4, y: activeSelectionTop, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4), isSmall: true)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(smallBowlSelected)))
//        return view
//    }()
//
//    lazy var largeBowl: BowlSizeChoiceView = {
//        let view = BowlSizeChoiceView(frame: CGRect(x: self.view.center.x + 4, y: activeSelectionTop, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4), isSmall: false)
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(largeBowlSelected)))
//        return view
//    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.alpha = 0.5
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.alpha = 0
        button.setTitleColor(.white, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var checkoutButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundDefaultColor = .green
        button.isEnabled = false
        button.addTarget(self, action: #selector(checkoutButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Layout Constraint Variables
    var visibleBowlCollectionTopAnchor: NSLayoutConstraint?
    var hiddenBowlCollectionTopAnchor: NSLayoutConstraint?
    
    var visibleCerealCollectionTopAnchor: NSLayoutConstraint?
    var hiddenCerealCollectionTopAnchor: NSLayoutConstraint?
    
    var visibleMilkCollectionTopAnchor: NSLayoutConstraint?
    var hiddenMilkCollectionTopAnchor: NSLayoutConstraint?
    
    var orderCerealSlot1BottomAnchor: NSLayoutConstraint?
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Order"
        view.backgroundColor = main
        
        bowlCollectionView.register(BowlCollectionViewCell.self, forCellWithReuseIdentifier: bowlCellId)
        bowlCollectionView.delegate = self
        bowlCollectionView.dataSource = self
        
        cerealCollectionView.register(CerealCollectionViewCell.self, forCellWithReuseIdentifier: cerealCellId)
        cerealCollectionView.delegate = self
        cerealCollectionView.dataSource = self
        
        milkCollectionView.register(MilkCollectionViewCell.self, forCellWithReuseIdentifier: milkCellId)
        milkCollectionView.delegate = self
        milkCollectionView.dataSource = self
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
//        if order == nil {
//            UIView.animate(withDuration: 0.3) {
//                self.bowlCollectionView.frame.origin.y = self.selectionView.frame.origin.y
//            }
//        }
    }

    //MARK:- Private Methods
    
    private func setupViews() {
        
        setupYourOrderView()
        
//        view.addSubview(smallBowl)
//        view.addSubview(largeBowl)
        view.addSubview(instructionLabel)
        view.addSubview(selectionView)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(checkoutButton)
        
        instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: yourOrderView.bottomAnchor, constant: 32).isActive = true
        
        
        selectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        selectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        selectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8).isActive = true
        selectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -4).isActive = true
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -4).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        backButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -4).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        setupCollectionViews()
        
    }
    
    private func setupYourOrderView() {
        view.addSubview(yourOrderView)
        yourOrderView.addSubview(yourOrderLabel)
        yourOrderView.addSubview(orderBowlSlotImageView)
        yourOrderView.addSubview(orderCerealSlot1ImageView)
        yourOrderView.addSubview(orderCerealSlot2ImageView)
        yourOrderView.addSubview(orderMilkSlotImageView)
        
        yourOrderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        yourOrderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        yourOrderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        yourOrderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
        
        yourOrderLabel.topAnchor.constraint(equalTo: yourOrderView.topAnchor).isActive = true
        yourOrderLabel.leadingAnchor.constraint(equalTo: yourOrderView.leadingAnchor, constant: 4).isActive = true
        yourOrderLabel.trailingAnchor.constraint(equalTo: yourOrderView.trailingAnchor, constant: -4).isActive = true
        
        orderBowlSlotImageView.leadingAnchor.constraint(equalTo: yourOrderView.leadingAnchor).isActive = true
        orderBowlSlotImageView.topAnchor.constraint(equalTo: yourOrderView.topAnchor).isActive = true
        orderBowlSlotImageView.bottomAnchor.constraint(equalTo: yourOrderView.bottomAnchor).isActive = true
        orderBowlSlotImageView.widthAnchor.constraint(equalTo: yourOrderView.widthAnchor, multiplier: 0.33).isActive = true
        
        orderMilkSlotImageView.trailingAnchor.constraint(equalTo: yourOrderView.trailingAnchor).isActive = true
        orderMilkSlotImageView.topAnchor.constraint(equalTo: yourOrderView.topAnchor).isActive = true
        orderMilkSlotImageView.bottomAnchor.constraint(equalTo: yourOrderView.bottomAnchor).isActive = true
        orderMilkSlotImageView.widthAnchor.constraint(equalTo: yourOrderView.widthAnchor, multiplier: 0.33).isActive = true
        
        orderCerealSlot1ImageView.leadingAnchor.constraint(equalTo: orderBowlSlotImageView.trailingAnchor).isActive = true
        orderCerealSlot1ImageView.trailingAnchor.constraint(equalTo: orderMilkSlotImageView.leadingAnchor).isActive = true
        orderCerealSlot1ImageView.topAnchor.constraint(equalTo: yourOrderView.topAnchor).isActive = true
        orderCerealSlot1BottomAnchor = orderCerealSlot1ImageView.bottomAnchor.constraint(equalTo: yourOrderView.bottomAnchor)
        orderCerealSlot1BottomAnchor?.isActive = true
        
        orderCerealSlot2ImageView.leadingAnchor.constraint(equalTo: orderBowlSlotImageView.trailingAnchor).isActive = true
        orderCerealSlot2ImageView.trailingAnchor.constraint(equalTo: orderMilkSlotImageView.leadingAnchor).isActive = true
        orderCerealSlot2ImageView.topAnchor.constraint(equalTo: orderCerealSlot1ImageView.bottomAnchor).isActive = true
        orderCerealSlot2ImageView.bottomAnchor.constraint(equalTo: yourOrderView.bottomAnchor).isActive = true
    }
    
    private func setupCollectionViews() {
        view.addSubview(bowlCollectionView)
        view.addSubview(cerealCollectionView)
        view.addSubview(milkCollectionView)
        
        visibleBowlCollectionTopAnchor = bowlCollectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8)
        visibleBowlCollectionTopAnchor?.isActive = true
        hiddenBowlCollectionTopAnchor = bowlCollectionView.topAnchor.constraint(equalTo: selectionView.bottomAnchor)
        bowlCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bowlCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bowlCollectionView.bottomAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
        
        visibleCerealCollectionTopAnchor = cerealCollectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8)
//        hiddenCerealCollectionTopAnchor = cerealCollectionView.topAnchor.constraint(equalTo: selectionView.bottomAnchor)
        visibleCerealCollectionTopAnchor?.isActive = false
        cerealCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        cerealCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        cerealCollectionView.bottomAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true

        visibleMilkCollectionTopAnchor = milkCollectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8)
//        hiddenMilkCollectionTopAnchor = milkCollectionView.topAnchor.constraint(equalTo: selectionView.bottomAnchor)
        visibleMilkCollectionTopAnchor?.isActive = false
        milkCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        milkCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        milkCollectionView.bottomAnchor.constraint(equalTo: selectionView.bottomAnchor).isActive = true
    }
    
    private func setCerealOrderViews(){
//        view.addSubview(orderCerealSlot1ImageView)
//        view.addSubview(orderCerealSlot2ImageView)
//        view.sendSubviewToBack(orderCerealSlot1ImageView)
//        view.sendSubviewToBack(orderCerealSlot2ImageView)
//        if selectedCereals.count != 0 {
//            if !nextButton.isEnabled {
//                UIView.animate(withDuration: 0.2) {
//                    self.nextButton.isEnabled = true
//                    self.nextButton.alpha = 1
//                }
//            }
//            for i in 0...selectedCereals.count - 1 {
//                switch i {
//                case 0:
//                    orderCerealSlot1ImageView.image = selectedCereals[i].image
//                    orderCerealSlot2ImageView.image = nil
//                case 1:
//                    orderCerealSlot2ImageView.image = selectedCereals[i].image
//                default:
//                    print("No Cereals")
//                }
//            }
//        } else {
//            orderCerealSlot1ImageView.image = nil
//            orderCerealSlot2ImageView.image = nil
//            UIView.animate(withDuration: 0.2) {
//                self.nextButton.isEnabled = false
//                self.nextButton.alpha = 0.5
//            }
//        }
        print("count: \(selectedCereals.count)")
        if selectedCereals.count == 1 {
            orderCerealSlot1ImageView.image = selectedCereals[0].image
        } else {
            orderCerealSlot1BottomAnchor?.constant = -yourOrderView.frame.height / 2
            orderCerealSlot1ImageView.image = selectedCereals[0].image
            orderCerealSlot2ImageView.image = selectedCereals[1].image
        }
    }
    
    //MARK:- Actions
    
    @objc private func nextButtonPressed(){
        orderStage += 1
        
        switch orderStage {
        case 2:
            toCerealSelection()
        case 3:
            toMilkSelection()
        default:
            print("No next button action")
        }
    }
    
    @objc private func backButtonPressed(){
        orderStage -= 1
        
        switch orderStage {
        case 1:
            print("To bowl selection")
            toBowlSelection()
        case 2:
            print("To cereal selection")
            toCerealSelection()
        default:
            print("No back button action")
        }
    }
    
    @objc private func checkoutButtonPressed() {
        let checkoutVC = CheckoutViewController()
        if let bowl = bowl, let milk = milk {
            let newOrder = Order(bowl: bowl, cereals: selectedCereals, milk: milk)
            checkoutVC.order = newOrder
            navigationController?.pushViewController(checkoutVC, animated: true)
        } else {
            print("error creating order")
        }
    }
    
    //MARK:- Order Transitions
    
    private func toBowlSelection(){
        visibleBowlCollectionTopAnchor?.isActive = true
        visibleCerealCollectionTopAnchor?.isActive = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.instructionLabel.text = "Choose a Bowl Size"
            self.orderBowlSlotImageView.alpha = 1
            self.view.layoutIfNeeded()
            self.nextButton.isEnabled = true
            self.nextButton.alpha = 1
            self.backButton.isEnabled = false
            self.backButton.alpha = 0
        }) { (_) in
            print("Bowl animation done")
        }
    }
    
    private func toCerealSelection(){
        if bowl?.size == .small {
            orderBowlSlotImageView.image = UIImage(named: "bowl-filled")
        } else {
            orderBowlSlotImageView.image = UIImage(named: "bowl-filled")
        }
        visibleBowlCollectionTopAnchor?.isActive = false
        visibleCerealCollectionTopAnchor?.isActive = true
        visibleMilkCollectionTopAnchor?.isActive = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.instructionLabel.text = "Choose Your Cereal"
            self.orderBowlSlotImageView.alpha = 1
            self.view.layoutIfNeeded()
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.5
            self.backButton.isEnabled = true
            self.backButton.alpha = 1
        }) { (_) in
            print("Bowl animation done")
        }
        
    }
    
    private func toMilkSelection(){
        print("toMilkSelection")
        setCerealOrderViews()
        visibleCerealCollectionTopAnchor?.isActive = false
        visibleMilkCollectionTopAnchor?.isActive = true
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.instructionLabel.text = "Choose Your Milk"
            self.orderCerealSlot1ImageView.alpha = 1
            self.orderCerealSlot2ImageView.alpha = 1
            self.view.layoutIfNeeded()
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0
        }) { (_) in
            print("Bowl animation done")
        }
    }
    
    //MARK:- Collection Cell Functions
    private func bowlCellTapped(inCollection collectionView: UICollectionView, atIndexPath indexPath: IndexPath) {
        print("toCerealSelection")
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? BowlCollectionViewCell else {
            print("Cannot get tapped cell")
            return
        }
        for i in 0...collectionView.numberOfItems(inSection: 0) {
            let tempCell = collectionView.cellForItem(at: IndexPath(row: i, section: 0))
            tempCell?.layer.borderWidth = 0
        }
        cell.layer.borderWidth = 1
        if indexPath.row == 0 {
            bowl = Bowl(size: .small)
        } else {
            bowl = Bowl(size: .large)
        }
        UIView.animate(withDuration: 0.1) {
            self.nextButton.isEnabled = true
            self.nextButton.alpha = 1
        }
        
    }
    
    private func cerealCellTapped(inCollection collectionView: UICollectionView, atIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CerealCollectionViewCell else {
            print("Cannot get tapped cell")
            return
        }
        
        if selectedCereals.contains(Mock.cereal[indexPath.row]) {
            if let cerealToRemove = selectedCereals.firstIndex(of: Mock.cereal[indexPath.row]) {
                selectedCereals.remove(at: cerealToRemove)
                cell.layer.borderWidth = 0
            }
            if selectedCereals.count < 1 {
                UIView.animate(withDuration: 0.2) {
                    self.nextButton.isEnabled = false
                    self.nextButton.alpha = 0.5
                }
            }
        } else {
            if selectedCereals.count < 2 {
                cell.layer.borderWidth = 1
                selectedCereals.append(Mock.cereal[indexPath.row])
                
                UIView.animate(withDuration: 0.2) {
                    self.nextButton.isEnabled = true
                    self.nextButton.alpha = 1
                }
            }
        }
    }
    
    private func milkCellTapped(inCollection collectionView: UICollectionView, atIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MilkCollectionViewCell else {
            print("Cannot get tapped cell")
            return
        }
        
        for i in 0...collectionView.numberOfItems(inSection: 0) {
            let tempCell = collectionView.cellForItem(at: IndexPath(row: i, section: 0))
            tempCell?.layer.borderWidth = 0
        }
        cell.layer.borderWidth = 1
        self.milk = Mock.milk[indexPath.row]
        orderMilkSlotImageView.image = UIImage(named: "mockMilk")
        checkoutButton.isEnabled = true
        UIView.animate(withDuration: 0.1) {
//            self.checkoutButton.isEnabled = true
//            self.checkoutButton.alpha = 1
//            self.checkoutButton.backgroundColor = .green
            self.orderMilkSlotImageView.alpha = 1
        }
        
    }
}

extension NewOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case bowlCollectionView:
            return 2
        case cerealCollectionView:
            return Mock.cereal.count
        default:
             return Mock.milk.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case bowlCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bowlCellId, for: indexPath) as? BowlCollectionViewCell else {
                print("Error casting bowl cell")
                return UICollectionViewCell()
            }
            cell.layer.borderColor = UIColor.white.cgColor
            if indexPath.row == 0 {
                cell.updateCell(isSmall: true)
            }else {
                cell.updateCell(isSmall: false)
            }
            return cell
        case cerealCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cerealCellId, for: indexPath) as? CerealCollectionViewCell else {
                print("Error casting cereal cell")
                return UICollectionViewCell()
            }
            cell.layer.borderColor = UIColor.white.cgColor
            let name = Mock.cereal[indexPath.row].name
            let image = Mock.cereal[indexPath.row].image
            cell.updateCell(withName: name, image: image)
            if selectedCereals.contains(Mock.cereal[indexPath.row]){
                cell.layer.borderWidth = 1
            } else {
                cell.layer.borderWidth = 0
            }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: milkCellId, for: indexPath) as? MilkCollectionViewCell else {
                print("Error casting milk cell")
                return UICollectionViewCell()
            }
            cell.layer.borderColor = UIColor.white.cgColor
            cell.updateCell(withTitle: Mock.milk[indexPath.row].type.rawValue)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bowlCollectionView:
            let size = CGSize(width: view.frame.width, height: bowlCollectionView.frame.height * 0.48)
            print("bowl size")
            return size
        case cerealCollectionView:
            let size = CGSize(width: view.frame.width / 3.5, height: cerealCollectionView.frame.height * 0.48)
            return size
        default:
            let size = CGSize(width: view.frame.width / 3.5, height: milkCollectionView.frame.height * 0.48)
            return size
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case bowlCollectionView:
            bowlCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        case cerealCollectionView:
            cerealCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        default:
            //Milk Collection View
           milkCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        }
    }
    
    
}

