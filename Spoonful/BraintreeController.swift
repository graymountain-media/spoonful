//
//  BraintreeController.swift
//  Spoonful
//
//  Created by Jake Gray on 10/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import Alamofire

class BraintreeController {
    
    static let shared = BraintreeController()
    
    func fetchClientToken(forCustomerID custID: String, completion: @escaping (String?) -> Void) {
        let clientTokenURL = SettingsManager.shared.baseURL.appendingPathComponent("client_token")
        let params = [
            "customerId": custID
        ]
        Alamofire.request(clientTokenURL, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print("JSON: \(json)")
                    if let data = responseJSON.data {
                        let clientToken = String(data: data, encoding: String.Encoding.utf8)?.replacingOccurrences(of: "\"", with: "")
                        completion(clientToken)
                    } else {
                        print("Error getting data from response.")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error Getting Client Token: \(error.localizedDescription)")
                    completion(nil)
                }
        }
    }
    
    func createProductionBraintreeCustomer(withCustomer customer: Customer, completion: @escaping (String?) -> Void) {
        let createCustomerProductionURL = productionBaseURL.appendingPathComponent("create_customer")
        let params = [
            "firstName": customer.firstName,
            "lastName": customer.lastName,
            "email": customer.email
        ]
        
        Alamofire.request(createCustomerProductionURL, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print("JSON: \(json)")
                    if let data = responseJSON.data, let jsonString = json as? String {
                        print("JSON STRING: \(jsonString)")
                        completion(jsonString)
                    } else {
                        print("Error getting data from response.")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error Getting Customer ID: \(error.localizedDescription)")
                    completion(nil)
                }
        }
    }
    
    func createSandboxBraintreeCustomer(withCustomer customer: Customer, completion: @escaping (String?) -> Void) {
        let createCustomerSandboxURL = sandboxBaseURL.appendingPathComponent("create_customer")
        let params = [
            "firstName": customer.firstName,
            "lastName": customer.lastName,
            "email": customer.email
        ]
        
        Alamofire.request(createCustomerSandboxURL, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print("JSON: \(json)")
                    if let data = responseJSON.data, let jsonString = json as? String {
                        print("JSON STRING: \(jsonString)")
                        completion(jsonString)
                    } else {
                        print("Error getting data from response.")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error Getting Customer ID: \(error.localizedDescription)")
                    completion(nil)
                }
        }
    }
    
    func postTransationNonce(_ nonce: String, forAmount amount: Double, completion: @escaping(Bool) -> Void) {
        let chcekoutURL = SettingsManager.shared.baseURL.appendingPathComponent("checkout")
        
        let params = [
            "paymentMethodNonce": nonce,
            "amount": String(amount)
        ]
    
        Alamofire.request(chcekoutURL, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print("JSON: \(json)")
                    guard let results = json as? [String: Any] else {
                        completion(false)
                        return
                    }
                    
                    if let success = results["success"] as? Bool {
                        completion(success)
                        return
                    }
                    completion(false)
                    return
                case .failure(let error):
                    print("Error Getting Customer ID: \(error.localizedDescription)")
                    completion(false)
                    return
                }
        }
    }
}
