//
//  LocalArticle.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
import RealmSwift

class LocalArticle: Object {
    @Persisted var author: String = ""
    @Persisted var title: String = ""
    @Persisted var source: LocalSource?
    @Persisted var articalDescription: String = ""
    @Persisted var urlToImage: String = ""
    @Persisted var url: String = ""
    @Persisted var content: String = ""
    @Persisted var publishedAt: String = ""
    @Persisted var isFav: Bool = false
   
    convenience init(author:String, source: LocalSource,  title: String, description: String, url: String, urlToImage: String, content: String, publishedAt: String, isFav: Bool) {
        self.init()
        self.author = author
        self.source = source
        self.title = title
        self.url = url
        self.articalDescription = description
        self.content = content
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.isFav = isFav
    }
}
