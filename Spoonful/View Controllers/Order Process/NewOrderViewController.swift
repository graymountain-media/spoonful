//
//  BuildViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    var total = 3.50 {
        didSet {
            if total == 3.5 {
                totalLabel.text = "$3.50"
            } else if total == 5.30 {
                totalLabel.text = "$5.30"
            } else {
                totalLabel.text = "$\(total)"
            }
            
        }
    }
    
    //MARK:- Properties
    let selectionCellId = "SelectionCell"
    let bowlCellId = "BowlCell"
    let cerealCellId = "CerealCell"
    let milkCellId = "MilkCell"
    
    
    lazy var activeSelectionTop: CGFloat = self.view.center.y - self.view.frame.width * 0.2
    lazy var discardOriginX: CGFloat = self.view.frame.width + 5
    
    var orderStage = 1
    
    //New Order Properties
    var selectedCereals: [Cereal] = []
    var milk: Milk?
    var order: Order?
    
    //MARK:- Objects
    
    let orderBowlSlotImageView: UIImageView = {
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
    
    let yourOrderView: UIStackView = {
        let view = UIStackView(frame: CGRect.zero)
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = darkOne
        view.distribution = .fillEqually
        view.spacing = 2
        
        let background: UIView = {
            let bgView = UIView()
            bgView.backgroundColor = darkOne
            bgView.translatesAutoresizingMaskIntoConstraints = false
            return bgView
        }()
        
        view.addSubview(background)
        background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -16).isActive = true
        background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        background.topAnchor.constraint(equalTo: view.topAnchor, constant: -32).isActive = true
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
        
        return view
    }()
    
    let totalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = darkOne
        return view
    }()
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "TOTAL"
        label.textColor = .white
        label.font = titleFont.withSize(24)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.50"
        label.textColor = .white
        label.font = titleFont.withSize(24)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "CHOOSE UP TO 2 CEREALS"
        label.textColor = .white
        label.font = titleFont.withSize(36)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yourOrderLabel : UILabel = {
        let label = UILabel()
        label.text = "YOUR ORDER:"
        label.font = titleFont.withSize(18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectionCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = lightOne
        view.isScrollEnabled = false
        view.isPagingEnabled = true
        return view
    }()
    
//    lazy var quantityCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .clear
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
    
    lazy var cerealCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var milkCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var nextButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Next", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 0
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var backButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.setTitle("Back", for: .normal)
        button.isEnabled = false
        button.layer.cornerRadius = 0
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
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Order"
        view.backgroundColor = main
        
        selectionCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: selectionCellId)
        selectionCollectionView.delegate = self
        selectionCollectionView.dataSource = self
        

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
    }

    //MARK:- Private Methods
    
    private func setupViews() {
        
        setupYourOrderView()
        
        view.addSubview(instructionLabel)
        view.addSubview(selectionCollectionView)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(checkoutButton)
        view.addSubview(totalView)
        
        instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        instructionLabel.topAnchor.constraint(equalTo: yourOrderView.bottomAnchor, constant: 8).isActive = true
        
        selectionCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        selectionCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        selectionCollectionView.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 8).isActive = true
        selectionCollectionView.bottomAnchor.constraint(equalTo: totalView.topAnchor).isActive = true
        
        totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        totalView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -4).isActive = true
        totalView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        nextButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 4).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: checkoutButton.trailingAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -4).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        backButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -4).isActive = true
        backButton.leadingAnchor.constraint(equalTo: checkoutButton.leadingAnchor).isActive = true
        backButton.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -4).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
//        setupCollectionViews()
        setupTotalView()
        
    }
    
    private func setupYourOrderView() {
        view.addSubview(yourOrderView)
        view.addSubview(yourOrderLabel)
        
        yourOrderView.topAnchor.constraint(equalTo: yourOrderLabel.bottomAnchor).isActive = true
        yourOrderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        yourOrderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        yourOrderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
        yourOrderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        yourOrderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        yourOrderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        
    }
    
    private func setup(collectionView: UICollectionView, inCell cell: UICollectionViewCell) {
        cell.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
    }
    
    private func setupTotalView() {
        totalView.addSubview(totalTitleLabel)
        totalView.addSubview(totalLabel)
        
        totalTitleLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 8).isActive = true
        totalTitleLabel.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -8).isActive = true
        totalTitleLabel.topAnchor.constraint(equalTo: totalView.topAnchor).isActive = true
        totalTitleLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor).isActive = true
        
        totalLabel.leadingAnchor.constraint(equalTo: totalView.leadingAnchor, constant: 8).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: totalView.trailingAnchor, constant: -8).isActive = true
        totalLabel.topAnchor.constraint(equalTo: totalView.topAnchor).isActive = true
        totalLabel.bottomAnchor.constraint(equalTo: totalView.bottomAnchor).isActive = true
    }
    
    //MARK:- Cereal Slot Management
    
    private func addFirstCereal() {
        let imageView = UIImageView(image: selectedCereals[0].image)
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFit
        yourOrderView.insertArrangedSubview(imageView, at: 0)
        UIView.animate(withDuration: 0.2, animations: {
            imageView.alpha = 1
            
        })
    }
    
    private func addSecondCereal(){
        let imageView = UIImageView(image: selectedCereals[1].image)
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFit
        yourOrderView.insertArrangedSubview(imageView, at: 1)
        UIView.animate(withDuration: 0.2, animations: {
            imageView.alpha = 1
            
        })
    }
    
    private func removeFirstCereal(){
        let imageView = yourOrderView.arrangedSubviews[0]
        UIView.animate(withDuration: 0.2, animations: {
            imageView.alpha = 0
            
        }) { (_) in
            self.yourOrderView.removeArrangedSubview(imageView)
        }
    }
    
    private func removeSecondCereal(){
        let imageView = yourOrderView.arrangedSubviews[1]
        UIView.animate(withDuration: 0.2, animations: {
            imageView.alpha = 0
        }) { (_) in
            self.yourOrderView.removeArrangedSubview(imageView)
        }
    }
    
    //MARK:- Actions
    
    @objc private func nextButtonPressed(){
        orderStage += 1
        
        switch orderStage {
        case 1:
            toCerealSelection()
        case 2:
            toMilkSelection()
        default:
            print("No next button action")
        }
    }
    
    @objc private func backButtonPressed(){
        orderStage -= 1
        
        switch orderStage {
//        case 1:
//            print("To bowl selection")
//            toBowlSelection()
        case 1:
            print("To cereal selection")
            toCerealSelection()
        default:
            print("No back button action")
        }
    }
    
    @objc private func checkoutButtonPressed() {
        let checkoutVC = CheckoutViewController()
        if let milk = milk {
            OrderController.shared.currentOrder.milk = milk
            OrderController.shared.currentOrder.cereals = selectedCereals
            OrderController.shared.currentOrder.total = total
            checkoutVC.order = OrderController.shared.currentOrder
            navigationController?.pushViewController(checkoutVC, animated: true)
        } else {
            print("error creating order")
        }
    }
    
    //MARK:- Order Transitions
    
//    private func toBowlSelection(){
//        selectionCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//        self.nextButton.isEnabled = true
//        self.backButton.isEnabled = false
//        self.instructionLabel.text = "CHOOSE A BOWL SIZE"
//    }
    
    private func toCerealSelection(){
        selectionCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        if selectedCereals.count == 0 {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
        self.backButton.isEnabled = false
        self.instructionLabel.text = "CHOOSE YOUR CEREAL"
        
    }
    
    private func toMilkSelection(){
        print("toMilkSelection")
        selectionCollectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.nextButton.isEnabled = false
        self.backButton.isEnabled = true
        self.instructionLabel.text = "CHOOSE YOUR MILK"
        
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
        orderBowlSlotImageView.image = UIImage(named: "bowl-filled")
        yourOrderView.addArrangedSubview(orderBowlSlotImageView)
        UIView.animate(withDuration: 0.2) {
            self.orderBowlSlotImageView.alpha = 1
        }
        self.nextButton.isEnabled = true
        
    }
    
    private func cerealCellTapped(inCollection collectionView: UICollectionView, atIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CerealCollectionViewCell else {
            print("Cannot get tapped cell")
            return
        }
        
        let selectedCereal = Products.cereal[indexPath.row]
        //Check if cereal was already selected
        if selectedCereals.contains(selectedCereal) {
            
            
            //Cereal was already selected
            if let cerealIndexToRemove = selectedCereals.firstIndex(of: Products.cereal[indexPath.row]) {
                selectedCereals.remove(at: cerealIndexToRemove)
                cell.layer.borderWidth = 0
                
                if cerealIndexToRemove == 0 {
                    print("remove first slot")
                    removeFirstCereal()
                } else {
                    print("remove second slot")
                    removeSecondCereal()
                }
                
            }
            if selectedCereals.count < 1 {
                self.nextButton.isEnabled = false
            }
            var containsPremiumCereal = false
            for cereal in selectedCereals {
                if cereal.isPremium {
                    containsPremiumCereal = true
                    break
                }
            }
            if selectedCereal.isPremium == true && containsPremiumCereal == false {
                total -= 0.25
            }
            
        } else {
            
            //Cereal was not already selected
            if selectedCereals.count < 2 {
                cell.layer.borderWidth = 1
                
                var containsPremiumCereal = false
                for cereal in selectedCereals {
                    if cereal.isPremium {
                        containsPremiumCereal = true
                        break
                    }
                }
                if containsPremiumCereal == false && selectedCereal.isPremium == true{
                    total += 0.25
                }
                
                selectedCereals.append(Products.cereal[indexPath.row])
                if selectedCereals.count == 1 {
                    print("add first slot")
                    addFirstCereal()
                } else {
                    print("add second slot")
                    addSecondCereal()
                }
                    self.nextButton.isEnabled = true
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
        if self.milk?.type == .almond {
            total -= 1.80
        }
        cell.layer.borderWidth = 1
        self.milk = Products.milk[indexPath.row]
        if Products.milk[indexPath.row].type == .almond {
            total += 1.80
        }
        orderMilkSlotImageView.image = UIImage(named: "mockMilk")
        yourOrderView.addArrangedSubview(orderMilkSlotImageView)
        checkoutButton.isEnabled = true
        UIView.animate(withDuration: 0.1) {
            self.orderMilkSlotImageView.alpha = 1
        }
        
    }
}

extension NewOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case selectionCollectionView:
            return 3
//        case quantityCollectionView:
//            return 2
        case cerealCollectionView:
            return Products.cereal.count
        default:
             return Products.milk.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case selectionCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: selectionCellId, for: indexPath)
            
            switch indexPath.row {
//            case 0:
//                setup(collectionView: quantityCollectionView, inCell: cell)
            case 0:
                setup(collectionView: cerealCollectionView, inCell: cell)
            default:
                setup(collectionView: milkCollectionView, inCell: cell)
            }
            return cell
//        case quantityCollectionView:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bowlCellId, for: indexPath) as? BowlCollectionViewCell else {
//                print("Error casting bowl cell")
//                return UICollectionViewCell()
//            }
//            cell.layer.borderColor = UIColor.white.cgColor
//            if indexPath.row == 0 {
//                cell.updateCell(isSmall: true)
//            }else {
//                cell.updateCell(isSmall: false)
//            }
//            return cell
        case cerealCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cerealCellId, for: indexPath) as? CerealCollectionViewCell else {
                print("Error casting cereal cell")
                return UICollectionViewCell()
            }
            let cereal = Products.cereal[indexPath.row]
            cell.layer.borderColor = UIColor.white.cgColor
            var name = ""
            if cereal.isPremium {
                name += "$0.25"
            }
            
            let image = cereal.image
            cell.updateCell(withName: name, image: image)
            if selectedCereals.contains(cereal){
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
            let milkTitle = Products.milk[indexPath.row].type.rawValue
            var milkSubTitle = ""
            if Products.milk[indexPath.row].type == .almond {
                milkSubTitle = "1.80"
            }
            
            
            cell.updateCell(withTitle: milkTitle, subtitle: milkSubTitle == "" ? "" : "+$\(milkSubTitle)")
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case selectionCollectionView:
            let size = CGSize(width: view.frame.width, height: selectionCollectionView.frame.height)
            return size
        case cerealCollectionView:
            let size = CGSize(width: view.frame.width / 3.5, height: cerealCollectionView.frame.height * 0.45)
            return size
        default:
            let size = CGSize(width: milkCollectionView.frame.width * 0.48, height: milkCollectionView.frame.height * 0.48)
            return size
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
//        case quantityCollectionView:
//            bowlCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        case cerealCollectionView:
            cerealCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        default:
            //Milk Collection View
           milkCellTapped(inCollection: collectionView, atIndexPath: indexPath)
        }
    }
    
    
}
