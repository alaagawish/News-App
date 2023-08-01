//
//  LocalSourceProtocol.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation

protocol LocalSourceProtocol{
    func insertArticle(article: LocalArticle)
    
    func getArticlesFromLocal() -> [LocalArticle]
    
    func getArticleFromLocal(title: String)  -> LocalArticle?
    
    func addFav(article: LocalArticle)
    
    func deleteFromLocal(article:LocalArticle)
    
    func isFavourite(title:String) -> Bool
    
    func deleteAll()
       
}
