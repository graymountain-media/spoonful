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
}
