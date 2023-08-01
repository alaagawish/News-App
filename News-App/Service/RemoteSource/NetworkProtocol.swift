//
//  NetworkProtocol.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
import Alamofire

protocol NetworkProtocol{
    func getData(path: String, parameters: Alamofire.Parameters, handler: @escaping (NewsResponse?) -> Void)
}
