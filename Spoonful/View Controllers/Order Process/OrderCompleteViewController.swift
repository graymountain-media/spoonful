//
//  OrderCompleteViewController.swift
//  Spoonful
//
//  Created by Jake Gray on 11/8/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import UIKit

class OrderCompleteViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Complete!"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Hang tight, we'll be there soon!"
        label.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let checkMarkImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "checkmarkGreen")
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.alpha = 0
        return imageview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = main
        setupViews()
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimations()
    }
    
    private func setupViews(){
        view.addSubview(titleLabel)
        view.addSubview(detailLabel)
        view.addSubview(checkMarkImageView)
        
        checkMarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkMarkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        checkMarkImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        checkMarkImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: checkMarkImageView.topAnchor, constant: -8).isActive = true
        
        detailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        detailLabel.topAnchor.constraint(equalTo: checkMarkImageView.bottomAnchor, constant: 8).isActive = true

    }
    
    private func startAnimations() {
        UIView.animate(withDuration: 0.2, animations: {
            self.checkMarkImageView.alpha = 1
            self.checkMarkImageView.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
            
        }) { (_) in
            UIView.animate(withDuration: 0.2, animations: {
                self.checkMarkImageView.transform = CGAffineTransform(scaleX: 1.0,y: 1.0)
                
            }, completion: { (_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
