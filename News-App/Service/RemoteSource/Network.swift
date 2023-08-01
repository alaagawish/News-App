//
//  Network.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
import Alamofire

class Network: NetworkProtocol{
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (NewsResponse?) -> Void) {
           
           let headers: HTTPHeaders = [
               "X-Shopify-Access-Token": "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"
           ]
           
           AF.request("https://mad43-sv-ios1.myshopify.com/admin/api/2023-04/\(path).json",parameters: parameters, headers: headers).responseDecodable(of: NewsResponse.self) { response in
               switch response.result {
               case .success(let data):
                   handler(data)
               case .failure(let error):
                   print("Error: \(error)")
               }
               
           }
       }
        
    
    
}
