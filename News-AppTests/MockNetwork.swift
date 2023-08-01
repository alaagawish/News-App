//
//  MockNetwork.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//
import Foundation
@testable import News_App
@testable import Alamofire

class MockNetwork: NetworkProtocol{
    
    
    var isSuccess: Bool!
    init(isSuccess: Bool!) {
        self.isSuccess = isSuccess
    }
    
    let files = MockAPIFileLoader().loadApiFiles()
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (News_App.NewsResponse?) -> Void) {
        
            if isSuccess {
                handler(files)
            }else {
                handler(NewsResponse(status: "", totalResults: 0, articles: []))
            }
    }
    
    
    
}
