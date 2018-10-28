//
//  BuildViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 9/28/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class NewOrderViewController: UIViewController {
    
    //Mock Data
    let mockCereals = [Cereal(name: "Cheerios", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Frosted Flakes", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Reese's Puffs", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Fruit Loops", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Frosted Mini Wheats", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Cinnimon Toast Cruch", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Kix", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Fruity Pebels", image: UIImage(named: "mockLogo") ?? UIImage()),
                       Cereal(name: "Honeycomb", image: UIImage(named: "mockLogo") ?? UIImage())]
    let mockMilk = ["2%", "Whole", "Skim", "Almond", "Soy"]
    
    //MARK:- Properties
    let cerealCellId = "CerealCell"
    let milkCellId = "MilkCell"
    lazy var activeSelectionTop: CGFloat = self.view.center.y - self.view.frame.width * 0.2
    lazy var discardOriginX: CGFloat = self.view.frame.width + 5
    
    //MARK:- Objects
    
    lazy var firstOrderSlot: CGRect = CGRect(x: yourOrderView.frame.origin.x, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33, height: yourOrderView.frame.height)
    
    lazy var secondOrderSlot: CGRect = CGRect(x: yourOrderView.frame.origin.x + yourOrderView.frame.width * 0.33, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33, height: yourOrderView.frame.height)
    
    lazy var thirdOrderSlot: CGRect = CGRect(x: yourOrderView.frame.origin.x + yourOrderView.frame.width * 0.66 + 10, y: yourOrderView.frame.origin.y, width: yourOrderView.frame.width * 0.33 - 10, height: yourOrderView.frame.height)
    
    
    let yourOrderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.borderWidth = 1
//        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose a Bowl Size"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yourOrderLabel : UILabel = {
        let label = UILabel()
        label.text = "Your Order:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.0
        return label
    }()
    
    lazy var cerealCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.width * 0.4), collectionViewLayout: layout)
        collectionView.backgroundColor = main
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var milkCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: self.view.frame.height + 10, width: self.view.frame.width, height: self.view.frame.width * 0.4), collectionViewLayout: layout)
        collectionView.backgroundColor = main
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var smallBowl: BowlSizeChoiceView = {
        let view = BowlSizeChoiceView(frame: CGRect(x: self.view.center.x - self.view.frame.width * 0.4 - 4, y: activeSelectionTop, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4), isSmall: true)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(smallBowlSelected)))
        return view
    }()
    
    lazy var largeBowl: BowlSizeChoiceView = {
        let view = BowlSizeChoiceView(frame: CGRect(x: self.view.center.x + 4, y: activeSelectionTop, width: self.view.frame.width * 0.4, height: self.view.frame.width * 0.4), isSmall: false)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(largeBowlSelected)))
        return view
    }()
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New Order"
        view.backgroundColor = main
        
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
        view.addSubview(yourOrderView)
        view.addSubview(yourOrderLabel)
        view.addSubview(smallBowl)
        view.addSubview(largeBowl)
        view.addSubview(instructionLabel)
        view.addSubview(cerealCollectionView)
        view.addSubview(milkCollectionView)
        
        yourOrderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        yourOrderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        yourOrderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        
        yourOrderView.topAnchor.constraint(equalTo: yourOrderLabel.bottomAnchor).isActive = true
        yourOrderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 4).isActive = true
        yourOrderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -4).isActive = true
        yourOrderView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13).isActive = true
        
        
        instructionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        instructionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 16).isActive = true
        instructionLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -self.view.frame.width * 0.2 - 8).isActive = true
    }
    
    //MARK:- Actions
    
    @objc private func smallBowlSelected(){
        print("Small bowl selected")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            self.yourOrderLabel.alpha = 1
            self.smallBowl.frame = self.firstOrderSlot
            self.largeBowl.frame.origin.x = self.discardOriginX
            self.cerealCollectionView.frame.origin.y = self.activeSelectionTop
            self.instructionLabel.text = "Choose a Cereal"
        }) { (_) in
            print("animation done")
        }
    }
    
    @objc private func largeBowlSelected(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            self.yourOrderLabel.alpha = 1
            self.largeBowl.frame = self.firstOrderSlot
            self.smallBowl.frame.origin.x = self.discardOriginX
            self.cerealCollectionView.frame.origin.y = self.activeSelectionTop
            self.instructionLabel.text = "Choose a Cereal"
        }) { (_) in
            print("animation done")
        }
    }
}

extension NewOrderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cerealCollectionView {
            return mockCereals.count
        } else {
            return mockMilk.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cerealCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cerealCellId, for: indexPath) as? CerealCollectionViewCell else {
                print("Error casting cereal cell")
                return UICollectionViewCell()
            }
            let name = mockCereals[indexPath.row].name
            let image = mockCereals[indexPath.row].image
            cell.updateCell(withName: name, image: image)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: milkCellId, for: indexPath) as? MilkCollectionViewCell else {
                print("Error casting milk cell")
                return UICollectionViewCell()
            }
            cell.updateCell(withTitle: mockMilk[indexPath.row])
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cerealCollectionView {
            let size = CGSize(width: view.frame.width / 3.5, height: cerealCollectionView.frame.height)
            return size
        } else {
            let size = CGSize(width: cerealCollectionView.frame.height, height: cerealCollectionView.frame.height)
            return size
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == cerealCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CerealCollectionViewCell else {
                print("Cannot get tapped cell")
                return
            }
            let x = collectionView.frame.origin.x + cell.frame.origin.x + cell.imageView.frame.origin.x - collectionView.contentOffset.x
            let y = collectionView.frame.origin.y + cell.imageView.frame.origin.y
            let size = cell.imageView.frame.size
            
            let selectedCereal = UIImageView(frame: CGRect(origin: CGPoint(x: x, y: y), size: size))
            selectedCereal.image = mockCereals[indexPath.row].image
            selectedCereal.contentMode = .scaleAspectFit
            view.addSubview(selectedCereal)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                selectedCereal.frame = self.secondOrderSlot
                self.cerealCollectionView.frame.origin.x = self.discardOriginX
                self.milkCollectionView.frame.origin.y = self.activeSelectionTop
                self.instructionLabel.text = "Choose Your Milk"
            }) { (_) in
                print("animation done")
            }
        } else {
            //Milk Collection View
            guard let cell = collectionView.cellForItem(at: indexPath) as? MilkCollectionViewCell else {
                print("Cannot get tapped cell")
                return
            }
            let x = milkCollectionView.frame.origin.x + cell.frame.origin.x - collectionView.contentOffset.x 
            let y = milkCollectionView.frame.origin.y + cell.frame.origin.y
            let size = cell.frame.size
            let selectedMilk = UILabel(frame: CGRect(origin: CGPoint(x: x, y: y), size: size))
            selectedMilk.text = mockMilk[indexPath.row]
            selectedMilk.textColor = .white
            selectedMilk.font = UIFont.boldSystemFont(ofSize: 56)
            selectedMilk.adjustsFontSizeToFitWidth = true
            selectedMilk.textAlignment = .center
            view.addSubview(selectedMilk)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                selectedMilk.frame = self.thirdOrderSlot
//                self.milkCollectionView.frame.origin.x = self.discardOriginX
                self.instructionLabel.text = "Choose Your Milk"
            }) { (_) in
                print("animation done")
            }
        }
    }
    
    
}

