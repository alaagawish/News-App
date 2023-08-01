//
//  LocalSourceProtocol.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
protocol LocalSourceProtocol{
    func insertArticle(article: LocalArticle)
    
    func getArticalsFromLocal() -> [LocalArticle]
    
    func getArticalFromLocal(title: String)  -> LocalArticle?
    
    func deleteFromLocal(title: String)
    func isFavourite(title:String) -> Bool
}
