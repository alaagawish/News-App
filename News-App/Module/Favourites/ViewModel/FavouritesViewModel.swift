//
//  FavouritesViewModel.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
class FavouritesViewModel {
    var refreshFavouriteArticles: (()->()) = {}
       var articles: [LocalArticle]?{
           didSet{
               print("Refreshing fav table")
               refreshFavouriteArticles()
           }
       }
       var returnFavouriteLeague: (()->()) = {}
       var article: LocalArticle?{
           didSet{
               print("Return selected league")
               refreshFavouriteArticles()
           }
       }
       
       var localSource: LocalSourceProtocol
       init( localSource: LocalSourceProtocol) {
           self.localSource = localSource
       }
       
       func getArticles() -> [LocalArticle]{
           articles = localSource.getArticlesFromLocal()
           print("Refreshing fav table")
           return articles ?? []
       }
       
    func deleteArticle(article: LocalArticle){
           localSource.deleteFromLocal(article: article)
           let _ = getArticles()
       }
       
       func getSelectedArticle(title: String) -> LocalArticle{
           article = localSource.getArticleFromLocal(title: title)
           print("Return selected article")
           return article!
       }
}
