//
//  MockLocalSource.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import XCTest
@testable import News_App

class MockLocalSource: LocalSourceProtocol {
    var favouriteArticles: [LocalArticle] = []
    
    func insertArticle(article: News_App.LocalArticle) {
        favouriteArticles.append(article)
    }
    
    func getArticlesFromLocal() -> [News_App.LocalArticle] {
        return favouriteArticles
    }
    
    func getArticleFromLocal(title: String) -> News_App.LocalArticle? {
        var articleObj: LocalArticle!
        for article in favouriteArticles {
            if(article.title == title) {
                articleObj = article
                break
            }
        }
        return articleObj
    }
    
    func addFav(article: News_App.LocalArticle) {
        favouriteArticles.append(LocalArticle(author: article.author, source: LocalSource(id: article.source?.id ?? "", name: article.source?.name ?? ""), title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, content: article.content, publishedAt: article.publishedAt, isFav: true))
    }
    
    func deleteFromLocal(article: News_App.LocalArticle) {
        for i in 0 ..< favouriteArticles.count {
            if favouriteArticles[i].title == article.title {
                favouriteArticles.remove(at: i)
                break
            }
        }
    }
    
    func isFavourite(title: String) -> Bool {
        for i in favouriteArticles {
            if i.isFav {
                return true
            }
        }
        return false
    }
    
    func deleteAll() {
        favouriteArticles = []
    }
    
}
