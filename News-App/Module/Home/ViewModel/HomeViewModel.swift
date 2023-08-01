//
//  HomeViewModel.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
class HomeViewModel {
    
    var network: NetworkProtocol!
    var passArticlesToViewController: (()->()) = {}
    var articles: [Article]!{
        didSet{
            passArticlesToViewController()
        }
    }
    init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getData(){
        
        network.getData(path: "", parameters: ["" : ""], handler: { [weak self] (response: NewsResponse!) in
            
            self?.articles = response.articles
        })
    }
}
