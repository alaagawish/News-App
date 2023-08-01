//
//  Local.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
import RealmSwift

class Local: LocalSourceProtocol{
    
    static let instance = Local()
    
    let realm: Realm
    private init() {
        
        realm = try! Realm()
        
    }
    func insertArticle(article: LocalArticle) {
        do {
            realm.beginWrite()
            realm.add(article)
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addFav(article: LocalArticle) {
        do {
            article.isFav = true
            realm.beginWrite()
            realm.add(article)
            print("add donnnnnnne")
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getArticlesFromLocal() -> [LocalArticle] {
        return Array(realm.objects(LocalArticle.self))
    }
    
    func getArticleFromLocal(title: String) -> LocalArticle? {
        let allArticlesList = getArticlesFromLocal()
        var articleObj: LocalArticle!
        for article in allArticlesList {
            if(article.title == title) {
                articleObj = article
                break
            }
        }
        return articleObj
    }
    
    func deleteFromLocal(article: LocalArticle) {
        let allArticlesList = getArticlesFromLocal()
        var articleObj: LocalArticle!
        for article in allArticlesList {
            if(article.title == article.title && article.isFav ) {
                articleObj = article
                break
            }
        }
        do {
            realm.beginWrite()
            realm.delete(articleObj)
            try realm.commitWrite()
        } catch let error {
            
            print(error.localizedDescription)
        }
    }
    
    func isFavourite(title: String) -> Bool {
        let allArticlesList = getArticlesFromLocal()
        
        for article in allArticlesList {
            if(article.title == title && article.isFav == true) {
                return true
            }
        }
        return false
    }
    
    func deleteAll() {
        let allArticles = getArticlesFromLocal()
        var favArticles: [LocalArticle] = []
        for article in allArticles {
            if article.isFav == true {
                favArticles.append(article)
            }
        }
        do {
            realm.beginWrite()
            realm.deleteAll()
            try realm.commitWrite()
        } catch let error {
         
            print(error.localizedDescription)
        }
        print(favArticles.count)
        if  favArticles.count > 0 {
            for article in favArticles {
                addFav(article: article)
            }
        }
    }
    
}
