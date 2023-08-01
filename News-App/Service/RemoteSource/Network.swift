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
        
        AF.request(Constants.url).responseDecodable(of: NewsResponse.self) { response in
            print(response)
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
}

