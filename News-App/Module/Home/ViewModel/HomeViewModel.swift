//
//  HomeViewModel.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
class HomeViewModel {
    
    var network: NetworkProtocol!
    var localSource: LocalSourceProtocol
    var passArticlesToViewController: (()->()) = {}
    var articles: [Article]!{
        didSet{
            passArticlesToViewController()
        }
    }
    init(network: NetworkProtocol, localSource: LocalSourceProtocol) {
        self.localSource = localSource
        self.network = network
    }
    
    func getData(){
        
        network.getData(path: "", parameters: ["" : ""], handler: { [weak self] (response: NewsResponse!) in
         
            self?.articles = response.articles
        })
    }
    func saveArticlesLocal() {
        for article in articles {
            localSource.insertArticle(article: LocalArticle(author: article.author ?? "", source: LocalSource(id: article.source.id ?? "",name: article.source.name), title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage ?? "", content: article.content, publishedAt: article.publishedAt, isFav: false))
        }
    }
    func getSavedArticles() -> [Article] {
        var articles = localSource.getArticlesFromLocal()
        var localArticles: [Article] = []
        for article in articles {
            if article.isFav == false {
                localArticles.append(Article(source: Source(id: article.source?.id, name: article.source?.name ?? ""), author: article.author, title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage, publishedAt: article
                    .publishedAt, content: article.content))
            }
        }
        return localArticles
    }
    
    func deleteAll() {
        localSource.deleteAll()
        let _ = getSavedArticles()
    }
}
