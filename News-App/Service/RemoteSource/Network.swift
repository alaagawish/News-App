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
        
        AF.request("https://newsapi.org/v2/everything?from=2023-07-01&sortBy=publishedAt&q=tesla&apiKey=f707f8e87fcb49118d3d12ca797cde81",parameters: parameters).responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    
    
}
