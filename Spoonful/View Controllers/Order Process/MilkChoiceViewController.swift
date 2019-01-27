//
//  MilkChoiceViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/10/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class MilkChoiceViewController: UIViewController {
    
    let cellID = "MilkCell"
    var currentSelection = 0
    
    let titleLabel: SpoonfulTitleLabel = {
        let label = SpoonfulTitleLabel()
        label.text = "What milk would you like with that?"
        return label
    }()
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = lightOne
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let milkCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Milk Choice"
        view.backgroundColor = main
        
        milkCollectionView.register(MilkCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        milkCollectionView.delegate = self
        milkCollectionView.dataSource = self
        
        setupViews()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(milkCollectionView)
        view.addSubview(checkoutButton)
        
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        
        checkoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        milkCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        milkCollectionView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -16).isActive = true
        milkCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        milkCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
    }
    
    // MARK: - Button Actions
    
    @objc private func checkoutButtonPressed() {
        let checkoutVC = CheckoutViewController()
        
        checkoutVC.order = OrderController.shared.currentOrder
        navigationController?.pushViewController(checkoutVC, animated: true)
    }
    
}

extension MilkChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Products.milk.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MilkCollectionViewCell else {
            print("Error casting milk cell")
            return UICollectionViewCell()
        }
        cell.layer.borderColor = UIColor.white.cgColor
        let milkTitle = Products.milk[indexPath.row].type.rawValue
        var milkSubTitle = ""
        if Products.milk[indexPath.row].type == .almond {
            milkSubTitle = "Coming Soon"
            cell.alpha = 0.5
            cell.isUserInteractionEnabled = false
        }
        cell.updateCell(withTitle: milkTitle, subtitle: milkSubTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: milkCollectionView.frame.width * 0.48, height: milkCollectionView.frame.height * 0.32)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cellTapped")
        guard let cell = collectionView.cellForItem(at: indexPath) as? MilkCollectionViewCell else {
            print("Cannot get tapped cell")
            return
        }
        if indexPath.row == currentSelection {
            return
        } else {
            currentSelection = indexPath.row
        }
        for i in 0...collectionView.numberOfItems(inSection: 0) {
            let tempCell = collectionView.cellForItem(at: IndexPath(row: i, section: 0))
            tempCell?.layer.borderWidth = 0
            tempCell?.isSelected = false
        }
        cell.layer.borderWidth = 1
        if let currentMilk = OrderController.shared.currentOrder.milk, currentMilk.type == .almond && Products.milk[indexPath.row].type != .almond {
            OrderController.shared.currentOrder.total -= 1.80
        }
        OrderController.shared.currentOrder.milk = Products.milk[indexPath.row]
        if Products.milk[indexPath.row].type == .almond {
            OrderController.shared.currentOrder.total += 1.80
        }
        checkoutButton.isEnabled = true
        
    }
    
}
