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
            refreshFavouriteArticles()
        }
    }
    var returnFavouriteArticle: (()->()) = {}
    var article: LocalArticle?{
        didSet{
            refreshFavouriteArticles()
        }
    }
    
    var localSource: LocalSourceProtocol
    init( localSource: LocalSourceProtocol) {
        self.localSource = localSource
    }
    
    func getArticles() {
        articles = localSource.getArticlesFromLocal()
        
    }
    
    func deleteArticle(article: LocalArticle){
        localSource.deleteFromLocal(article: article)
        let _ = getArticles()
    }
    
    func getSelectedArticle(title: String) -> LocalArticle{
        article = localSource.getArticleFromLocal(title: title)
        
        return article!
    }
    
    func getFavouriteArticles() -> [Article] {
        let articles = localSource.getArticlesFromLocal()
        var favArticles: [Article] = []
        for article in articles {
            if article.isFav == true {
                favArticles.append(Article(source: Source(id: article.source?.id, name: article.source?.name ?? ""), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article
                    .publishedAt, content: article.content))
            }
        }
        return favArticles
    }
}
