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
    
    //MARK:- Components
    let mainTable: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = offWhite
        table.isScrollEnabled = false
        return table
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = main
        self.title = "Checkout"
        // Do any additional setup after loading the view.
        
        setupTable()
    }
    
    init() {
        let customerContext = STPCustomerContext(keyProvider: StripeController.shared)
        self.paymentContext = STPPaymentContext(customerContext: customerContext)
        
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        self.paymentContext.hostViewController = self
        self.paymentContext.paymentAmount = 5000 // This is in cents, i.e. $50 USD
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTable() {
        mainTable.delegate = self
        mainTable.dataSource = self
//        mainTable.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(mainTable)
        
        mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

    }
}
extension CheckoutViewController: STPPaymentContextDelegate {

    //MARK: - STPPaymentContextDelegate
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        print("didFailToLoadWithError \(error.localizedDescription)")
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        print("paymentContextDidChange")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        print("didCreatePaymentResult")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        print("didFinishWith")
    }
    

}

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: cellIdentifier)
        cell.backgroundColor = .white
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Your Order"
                cell.isUserInteractionEnabled = false
            default:
                cell.isUserInteractionEnabled = false
                cell.textLabel?.text = "Total"
                cell.detailTextLabel?.text = "$5.00"
            }
        default:
            cell.textLabel?.text = "Payment"
            cell.detailTextLabel?.text = "Select Payment"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            switch indexPath.row{
            case 0:
                return 200
            default:
                return 50
            }
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Your Order"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section{
        case 1:
            paymentContext.presentPaymentMethodsViewController()
            tableView.deselectRow(at: indexPath, animated: true)
        default:
            return()
        }
        
    }
    
    
}
