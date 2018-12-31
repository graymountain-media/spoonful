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
        // TODO: Switch this URL to your own authenticated API
        let clientTokenURL = baseURL.appendingPathComponent("client_token")
//        let clientTokenRequest = NSMutableURLRequest(url: clientTokenURL as URL)
//        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        let params = [
            "customerId": custID
        ]
        
        
        
        Alamofire.request(clientTokenURL, method: .get, parameters: params, encoding: URLEncoding.queryString)
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    print("JSON: \(json)")
                    if let data = responseJSON.data {
                        let clientToken = String(data: data, encoding: String.Encoding.utf8)
                        completion(clientToken)
                    } else {
                        print("Error getting data from response.")
                        completion(nil)
                    }
                case .failure(let error):
                    print("Error Getting Client Token")
                    completion(nil)
                }
        }
        
        
//        URLSession.shared.dataTask(with: clientTokenRequest as URLRequest) { (data, response, error) -> Void in
//            // TODO: Handle errors
//            let clientToken = String(data: data!, encoding: String.Encoding.utf8)
//
//            // As an example, you may wish to present Drop-in at this point.
//            // Continue to the next section to learn more...
//            }.resume()
    }
    
    func postNonceToServer(paymentMethodNonce: String) {
        // Update URL with your server
        let paymentURL = URL(string: "https://your-server.example.com/payment-methods")!
        var request = URLRequest(url: paymentURL)
        request.httpBody = "payment_method_nonce=\(paymentMethodNonce)".data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
            // TODO: Handle success or failure
            }.resume()
    }

//    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
//        guard let baseURL = baseURL else {
//            print("Error getting base URL.")
//            return
//        }
//        let url = baseURL.appendingPathComponent("ephemeral_keys")
//        print(url)
//        print("api version: \(apiVersion)")
//        let params = [
//            "api_version": apiVersion,
//            "customerId": "cus_DqwaqT1523VD4f"
//        ]
//
//        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.queryString)
//            .validate(statusCode: 200..<300)
//            .responseJSON { responseJSON in
//                switch responseJSON.result {
//                case .success(let json):
//                    completion(json as? [String: AnyObject], nil)
//                case .failure(let error):
//                    completion(nil, error)
//                }
//        }
//    }
//
//    func completeCharge(_ result: STPPaymentResult,
//                        amount: Int,
//                        completion: @escaping STPErrorBlock) {
//        print("Source: \(result.source)")
//        let url = baseURL!.appendingPathComponent("charge")
//        let params: [String: Any] = [
//            "customer" : "cus_DqwaqT1523VD4f",
//            "amount": amount,
//            "currency": "USD",
//            "metadata": [
//                // example-ios-backend allows passing metadata through to Stripe
//                "charge_request_id": "B3E611D1-5FA1-4410-9CEC-00958A5126CB",
//            ],
//        ]
//        Alamofire.request(url, method: .post, parameters: params)
//            .validate(statusCode: 200..<300)
//            .responseString { response in
//                switch response.result {
//                case .success:
//                    completion(nil)
//                case .failure(let error):
//                    completion(error)
//                }
//        }
//    }
}
