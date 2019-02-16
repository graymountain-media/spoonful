//
//  CheckoutViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 10/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit
import Braintree
import BraintreeDropIn
import PassKit

class CheckoutViewController: UIViewController {
    
    //MARK:- Properties
    let cellIdentifier = "CheckoutCell"
    
    var total = 0.0
    
    let paymentCurrency = "usd"
    var clientToken: String = ""
    var paymentNonce: String = ""
    
    var order: Order?
    var customer: Customer?
    
    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = UIScreen.main.bounds
        blurView.isHidden = true
        blurView.alpha = 0
        return blurView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
    
    let nameView: CheckoutRow = {
        let view = CheckoutRow(title: "NAME", detail: "", tappable: false, frame: CGRect.zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let phoneNumberView: CheckoutRow = {
        let view = CheckoutRow(title: "PHONE NUMBER", detail: "", tappable: false)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let paymentView: CheckoutRow = {
        let view = CheckoutRow(title: "Payment Method", detail: "", tappable: true)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
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
        
        customer = CustomerController.shared.currentCustomer
        
        setupOrderView()
        setupRows()
        setupCompleteButton()
        setupViews()
        fetchClientToken()
    }
    
    //MARK: - Private Methods
    
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
            
            let orderStackView = UIStackView(arrangedSubviews: [orderFirstCerealImageView,orderMilkImageView])
            orderStackView.axis = .horizontal
            orderStackView.spacing = 4
            orderStackView.distribution = .fillEqually
            orderStackView.translatesAutoresizingMaskIntoConstraints = false
            
            orderFirstCerealImageView.image = order.cereals[0].image
            if order.cereals.count == 2 {
                orderStackView.insertArrangedSubview(orderSecondCerealImageView, at: 1)
                orderSecondCerealImageView.image = order.cereals[1].image
            }
            
            if let milk = order.milk {
               orderMilkImageView.image = UIImage(named: milk.imageName) 
            }
            
            orderView.addSubview(orderStackView)
            
            orderStackView.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 4).isActive = true
            orderStackView.bottomAnchor.constraint(equalTo: orderView.bottomAnchor, constant: -4).isActive = true
            orderStackView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 16).isActive = true
            orderStackView.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -16).isActive = true
            
            total = order.total
            if total == 3.5 {
                totalView.detail = "$3.50"
            } else if total == 5.30 {
                totalView.detail = "$5.30"
            } else {
                totalView.detail = "$\(total)"
            }
        } else {
            print("order not passed")
        }
    }
    
    private func setupRows() {
        view.addSubview(totalView)
        view.addSubview(nameView)
        view.addSubview(phoneNumberView)
        view.addSubview(paymentView)
        
//        totalView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: 50)
        totalView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        totalView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        totalView.topAnchor.constraint(equalTo: orderView.bottomAnchor).isActive = true
        totalView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        phoneNumberView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        phoneNumberView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        phoneNumberView.topAnchor.constraint(equalTo: totalView.bottomAnchor, constant: 16).isActive = true
        phoneNumberView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        nameView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        nameView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: phoneNumberView.bottomAnchor, constant: 16).isActive = true
        nameView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        paymentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        paymentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        paymentView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 16).isActive = true
        paymentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        if let order = order{
            nameView.detail = "\(order.firstName) \(order.lastName)"
            phoneNumberView.detail = order.phoneNumber
        }
        
        paymentView.onTap = {
            self.paymentButtonTapped()
        }
    }
    
    private func setupViews() {
        navigationController?.view.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor).isActive = true
    }
    
    private func setupCompleteButton() {
        view.addSubview(completeButton)
        
        completeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        completeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func startActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            self.blurEffectView.isHidden = false
            self.blurEffectView.alpha = 1
        }) { (_) in
            self.activityIndicator.startAnimating()
        }
    }
    
    private func stopActivityIndicator() {
        UIView.animate(withDuration: 0.3, animations: {
            self.activityIndicator.stopAnimating()
            self.blurEffectView.alpha = 0
        }) { (_) in
            self.blurEffectView.isHidden = true
        }
    }
    
    private func fetchClientToken() {
        paymentView.activityIndicator.startAnimating()
        if let customer = self.customer {
            var customerID = ""
            if SettingsManager.shared.isProduction {
                customerID = customer.prodCustomerID
            } else {
                customerID = customer.sandboxCustomerID
            }
            BraintreeController.shared.fetchClientToken(forCustomerID: customerID) { (token) in
                
                if let token = token {
                    self.clientToken = token
                    print("THE NEW TOKEN IS: \(token)")
                    self.paymentView.activityIndicator.stopAnimating()
                    self.paymentView.detail = "Select"
                    self.paymentView.isUserInteractionEnabled = true
                }
            }
        } else {
            print("Tokenization key used")
            clientToken = SettingsManager.shared.tokenizationKey
            paymentView.activityIndicator.stopAnimating()
            paymentView.detail = "Select"
            paymentView.isUserInteractionEnabled = true
        }
        
    }
    
    //MARK:- Button Actions
    @objc private func completeButtonPressed(){
        guard let order = order else {
            let alert = UIAlertController(title: "Order Failed", message: "The order was not able to be processed. Please try again.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okayAction)
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        order.isTestOrder = !SettingsManager.shared.isProduction
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        order.dateOrdered = formatter.string(from: Date())
        startActivityIndicator()
        BraintreeController.shared.postTransationNonce(paymentNonce, forAmount: total) { success in
            print("order attempt complete")
            print("SUCCESS: \(success)")
            self.stopActivityIndicator()
            if success {
                
                FirebaseController.shared.send(order: order, completion: { (success) in
                    if success {
                        let orderCompleteVC = OrderCompleteViewController()
                        self.navigationController?.pushViewController(orderCompleteVC, animated: true)
                    }
                })
        
            } else {
                let alert = UIAlertController(title: "Order Failed", message: "The order was not able to be processed. Please check your payment information or try another card.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alert.addAction(okayAction)
                self.present(alert, animated: true, completion: nil)
                
                
            }
        }
    }
    
    private func paymentButtonTapped() {
        let request =  BTDropInRequest()
        request.vaultManager = true
        request.paypalDisabled = true
        request.venmoDisabled = true
        print("FINAL CLIENT TOKEN: \(clientToken)")
        let dropIn = BTDropInController(authorization: clientToken, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                switch result.paymentOptionType {
                case .applePay:
                    controller.dismiss(animated: true, completion: nil)
                    
                    let paymentRequest = self.paymentRequest()
                    if let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) as PKPaymentAuthorizationViewController? {
                        paymentVC.delegate = self
                        self.present(paymentVC, animated: true, completion: nil)
                    } else {
                        print("Cannot make payment VC")
                    }
                    
                default:
                    guard let paymentMethod = result.paymentMethod else {
                        print("could not get payment method for nonce")
                        return
                    }
                    self.paymentNonce = paymentMethod.nonce
                }
                self.paymentView.detail = result.paymentDescription
                
                self.completeButton.isEnabled = true
            }
            controller.dismiss(animated: true, completion: nil)
        }
        if let dropIn = dropIn {
            self.present(dropIn, animated: true, completion: nil)
        } else {
            print("Drop in not created")
        }
        
    }
    
}

// MARK: - Apple Pay

extension CheckoutViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        print("paymentAuthorizationViewControllerDidFinish")
    }
    
    
    func paymentRequest() -> PKPaymentRequest {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = appleMerchantID
        paymentRequest.supportedNetworks = [PKPaymentNetwork.amex, PKPaymentNetwork.visa, PKPaymentNetwork.masterCard]
        paymentRequest.merchantCapabilities = PKMerchantCapability.capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        
        let orderSummaryItem = PKPaymentSummaryItem(label: "Test Oder", amount: 0.00)
        let totalSummaryItem = PKPaymentSummaryItem(label: "Total", amount: 3.50)
        let deliveryFeeSummaryItem = PKPaymentSummaryItem(label: "Delivery Fee", amount: 0.00)
        
        paymentRequest.paymentSummaryItems = [orderSummaryItem,totalSummaryItem,deliveryFeeSummaryItem]
        
        return paymentRequest
    }
    
}
//extension CheckoutViewController: ContactInfoDelegate {
//    func contactInfoEntered(firstName: String, lastName: String, phoneNumber: String) {
//        guard let order = order else {
//            print("No order on return from contact info")
//            return
//        }
//
//        order.firstName = firstName
//        order.lastName = lastName
//        order.phoneNumber = phoneNumber
//    }
//
//
//}
