//
//  DetailsViewModel.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation

class DetailsViewModel {
    var localSource: LocalSourceProtocol
    init( localSource: LocalSourceProtocol) {
        self.localSource = localSource
    }
    
    func checkFav(article: Article) -> Bool {
        return  localSource.isFavourite(title: article.title)
        
    }
    func addToFav(article: Article) {
        localSource.addFav(article: LocalArticle(author: article.author ?? "", source: LocalSource(id: article.source.id ?? "", name: article.source.name), title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage ?? "", content: article.content, publishedAt: article.publishedAt, isFav: true))
    }
    func removeFromFav(article: Article) {
        localSource.deleteFromLocal(article: LocalArticle(author: article.author ?? "", source: LocalSource(id: article.source.id ?? "", name: article.source.name), title: article.title, description: article.description, url: article.url, urlToImage: article.urlToImage ?? "", content: article.content, publishedAt: article.publishedAt, isFav: true))
    }
}
