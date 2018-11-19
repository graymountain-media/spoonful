//
//  CheckoutViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 10/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController {
    
    //MARK:- Properties
    let cellIdentifier = "CheckoutCell"
    
    let paymentContext: STPPaymentContext
    let paymentCurrency = "usd"
    
    var order: Order?
    
    let yourOrderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = titleFont.withSize(16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YOUR ORDER"
        label.backgroundColor = darkOne
        return label
    }()
    
    let orderView: UIView = {
        let view = UIView()
        view.backgroundColor = darkOne
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let orderBowlImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let orderFirstCerealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let orderSecondCerealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let orderMilkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //MARK: Rows
    
    let totalView: CheckoutRow = {
        let view = CheckoutRow(title: "TOTAL", detail: "$0.00", tappable: false, frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let paymentView: CheckoutRow = {
        let view = CheckoutRow(title: "PAYMENT", detail: "", frame: CGRect.zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let contactInfoView: CheckoutRow = {
        let view = CheckoutRow(title: "Contact Info", detail: ">")
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   
    
    lazy var completeButton: SpoonfulButton = {
        let button = SpoonfulButton()
        button.backgroundDefaultColor = .green
        button.isEnabled = false
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Complete Order", for: .normal)
        button.addTarget(self, action: #selector(completeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        self.title = "Checkout"
        // Do any additional setup after loading the view.

        setupOrderView()
        setupRows()
        setupCompleteButton()
    }
    
    init() {
        
        let customerContext = STPCustomerContext(keyProvider: StripeController.shared)
        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        guard let order = order else {return}
//        let userInformation = STPUserInformation()
//        paymentContext.prefilledInformation = userInformation
        paymentContext.paymentAmount = order.total
        paymentContext.paymentCurrency = self.paymentCurrency
        
        totalView.detail = "$ \(order.total/100)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupOrderView() {
        
        view.addSubview(orderView)
        view.addSubview(yourOrderLabel)
        
        orderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        orderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        orderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        orderView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        
        yourOrderLabel.bottomAnchor.constraint(equalTo: orderView.topAnchor).isActive = true
        yourOrderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        yourOrderLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    
        
        if let order = order {
            
            let orderStackView = UIStackView(arrangedSubviews: [orderBowlImageView,orderFirstCerealImageView,orderMilkImageView])
            orderStackView.axis = .horizontal
            orderStackView.spacing = 4
            orderStackView.distribution = .fillEqually
            orderStackView.translatesAutoresizingMaskIntoConstraints = false
            
            orderFirstCerealImageView.image = order.cereals[0].image
            orderBowlImageView.image = UIImage(named: "bowl-filled")
            if order.cereals.count == 2 {
                orderStackView.insertArrangedSubview(orderSecondCerealImageView, at: 2)
                orderSecondCerealImageView.image = order.cereals[1].image
            }
            
            orderMilkImageView.image = UIImage(named: "mockMilk")
            
            orderView.addSubview(orderStackView)
            
            orderStackView.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 4).isActive = true
            orderStackView.bottomAnchor.constraint(equalTo: orderView.bottomAnchor, constant: -4).isActive = true
            orderStackView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 16).isActive = true
            orderStackView.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -16).isActive = true
            
            
            
            
        } else {
            print("order not passed")
        }
    }
    
    private func setupRows() {
        view.addSubview(totalView)
        view.addSubview(paymentView)
        view.addSubview(contactInfoView)
        
//        totalView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 50)
        totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        totalView.topAnchor.constraint(equalTo: orderView.bottomAnchor).isActive = true
        totalView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        contactInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        contactInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        contactInfoView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: 16).isActive = true
        contactInfoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        paymentView.topAnchor.constraint(equalTo: contactInfoView.bottomAnchor, constant: 16).isActive = true
        paymentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        paymentView.onTap = { [weak self] in
            self?.paymentContext.pushPaymentMethodsViewController()
        }
        
        contactInfoView.onTap = {[weak self] in
            let contactVC = ContactInfoTableViewController()
            contactVC.delegate = self
            self?.navigationController?.pushViewController(contactVC, animated: true)
        }
    }
    
    private func setupCompleteButton() {
        view.addSubview(completeButton)
        
        completeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        completeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK:- Button Actions
    @objc private func completeButtonPressed(){
        self.paymentContext.requestPayment()
    }
    
}

extension CheckoutViewController: STPPaymentContextDelegate {

    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        print("didFailToLoadWithError \(error.localizedDescription)")
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        print("paymentContextDidChange")
        self.paymentView.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentView.detail = paymentMethod.label
        }
        else {
            self.paymentView.detail = "Select Payment"
        }
        if paymentContext.selectedPaymentMethod != nil {
            completeButton.isEnabled = true
//            UIView.animate(withDuration: 0.2) {
//                self.completeButton.isEnabled = true
//                self.completeButton.backgroundColor = .green
//                self.completeButton.alpha = 1
//            }
        } else {
            completeButton.isEnabled = false
//            UIView.animate(withDuration: 0.2) {
//                self.completeButton.isEnabled = false
//                self.completeButton.backgroundColor = .gray
//                self.completeButton.alpha = 0.5
//            }
        }
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        print("didCreatePaymentResult")
        guard let order = order else {return}
        StripeController.shared.completeCharge(paymentResult, amount: order.total, completion: { (error: Error?) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        })
        
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        print("didFinishWith")
        
        if let error = error {
            print("Error with charge: \(error.localizedDescription )")
        } else {
            navigationController?.pushViewController(OrderCompleteViewController(), animated: true)
        }
    }
    

}

extension CheckoutViewController: ContactInfoDelegate {
    func contactInfoEntered(firstName: String, lastName: String, phoneNumber: String) {
        guard let order = order else {
            print("No order on return from contact info")
            return
        }
        
        order.firstName = firstName
        order.lastName = lastName
        order.phoneNumber = phoneNumber
    }
    
    
}
