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
        do {
            realm.beginWrite()
            realm.delete(article)
            try realm.commitWrite()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func isFavourite(title: String) -> Bool {
        let allArticlesList = getArticlesFromLocal()
        
        for article in allArticlesList {
            if(article.title == title ) {
                return true
            }
        }
        return false
    }
    
    
}
