//
//  StripeController.swift
//  Spoonful
//
//  Created by Jake Gray on 10/23/18.
//  Copyright © 2018 Jake Gray. All rights reserved.
//

import Foundation
import Alamofire
import Stripe

class StripeController: NSObject, STPEphemeralKeyProvider {
    
    static let shared = StripeController()

    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        guard let baseURL = baseURL else {
            print("Error getting base URL.")
            return
        }
        let url = baseURL.appendingPathComponent("ephemeral_keys")
        print(url)
        print("api version: \(apiVersion)")
        let params = [
            "api_version": apiVersion,
            "customerId": "cus_DqwaqT1523VD4f"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        completion: @escaping STPErrorBlock) {
        print("Source: \(result.source)")
        let url = baseURL!.appendingPathComponent("charge")
        let params: [String: Any] = [
            "customer" : "cus_DqwaqT1523VD4f",
            "amount": amount,
            "currency": "USD",
            "metadata": [
                // example-ios-backend allows passing metadata through to Stripe
                "charge_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
            ],
        ]
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
}
