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
        
        let date = getCurrentDate()
        
        AF.request(Constants.url).responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: Constants.en)
        formatter.dateFormat = Constants.dateFormat
        return formatter.string(from: Date())
    }
    
}

