//
//  OrderListTableViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 1/17/19.
//  Copyright © 2019 Jake Gray. All rights reserved.
//

import UIKit

class OrderListTableViewController: UITableViewController {
    let cellID = "OrderCell"
    
    lazy var blurEffectView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = UIScreen.main.bounds
        blurView.isHidden = true
        blurView.alpha = 0
        return blurView
    }()
    
    lazy var customRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.attributedTitle = NSAttributedString(string: "Pull to refresh")
        control.addTarget(self, action: #selector(refreshTable), for: UIControl.Event.valueChanged)
        return control
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicatior = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicatior.hidesWhenStopped = true
        indicatior.translatesAutoresizingMaskIntoConstraints = false
        return indicatior
    }()
    
    var currentOrders: [Order] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OpenOrderTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.refreshControl = customRefreshControl
        
        view.addSubview(blurEffectView)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: blurEffectView.contentView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: blurEffectView.contentView.centerYAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurrentOrders()
    }
    
    // MARK: - Private Methods
    
    private func getCurrentOrders() {
        FirebaseController.shared.fetchCurrentOrders { (orders) in
            if let orders = orders {
                self.currentOrders = orders
            } else {
                self.currentOrders = []
            }
            if let control = self.tableView.refreshControl, control.isRefreshing {
                control.endRefreshing()
            }
        }
    }
    
    @objc private func refreshTable() {
        getCurrentOrders()
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentOrders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? OpenOrderTableViewCell else {
            return UITableViewCell()
        }
        
        let cereals = currentOrders[indexPath.row].cereals
        let date = currentOrders[indexPath.row].dateOrdered
        
        var title = ""
        title += cereals[0].name
        if cereals.count > 1 {
            title += " + \(cereals[1].name)"
        }
        
        cell.updateCellWith(name: title, date: date)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = currentOrders[indexPath.row]
        
        let orderDetailVC = OrderDetailViewController()
        orderDetailVC.order = order
        navigationController?.pushViewController(orderDetailVC, animated: true)
    }
    
}
