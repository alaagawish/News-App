//
//  LocalSourceTests.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//


import XCTest
@testable import News_App

final class LocalSourceTests: XCTestCase {
    
    var localSource: LocalSourceProtocol = Local.instance
    let article =  LocalArticle(author: "mirrornews@mirror.co.uk (Vassia Barba)", source: LocalSource(id: "", name: "Mirror Online"), title: "Huge 'X' sign at Twitter office angers residents living opposite pulsating light", description: "Elon Musk's 'X' ", url: "https://www.mirror.co.uk/news/us-news/huge-x-sign-twitter-office-30592056", urlToImage: "https://i2-prod.mirror.co.uk/incoming/article30592387.ece/ALTERNATES/s1200/2_Furious-residents-slam-huge-new-X-sign-above-Twitter-offices-that-pulsates-saying-this-is-my-life-n.jpg", content: "A huge 'X' sign at Twitter's head ", publishedAt: "2023-07-31T11:45:40Z", isFav: false)
    override func setUpWithError() throws {
        
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testInsertArticle() {
        localSource.deleteAll()
        let article =  LocalArticle(author: "author", source: LocalSource(id: "id", name: "name"), title: "title", description: "description", url: "url", urlToImage: "urlImage", content: "content", publishedAt: "date", isFav: false)
        XCTAssertEqual(localSource.getArticlesFromLocal().count, 0)
        localSource.insertArticle(article: article)
        XCTAssertNotNil(localSource.getArticlesFromLocal())
        XCTAssertEqual(localSource.getArticlesFromLocal().count, 1)
        localSource.deleteFromLocal(article: article)
        XCTAssertEqual(localSource.getArticlesFromLocal().count, 0)
    }
    
    func testGetArticlesFromLocal() {
        let count = localSource.getArticlesFromLocal().count
        XCTAssertNotNil(localSource.getArticlesFromLocal())
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 0)
        
    }
    
    func testGetArticleFromLocal() {
        let count = localSource.getArticlesFromLocal().count
        localSource.insertArticle(article: article)
        XCTAssertEqual(localSource.getArticleFromLocal(title: article.title)?.publishedAt, article.publishedAt)
        localSource.deleteFromLocal(article: article)
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 0)
    }
    
    func testAddFav() {
        let count = localSource.getArticlesFromLocal().count
        let article =  LocalArticle(author: "author", source: LocalSource(id: "id", name: "name"), title: "title", description: "description", url: "url", urlToImage: "urlImage", content: "content", publishedAt: "date", isFav: true)
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 0)
        localSource.addFav(article: article)
        XCTAssertNotNil(localSource.getArticlesFromLocal())
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 1)
        localSource.deleteFromLocal(article: article)
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 0)
    }
    
    func testDeleteFromLocal() {
        let count = localSource.getArticlesFromLocal().count
        localSource.addFav(article: article)
        
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 1)
        localSource.deleteFromLocal(article:article)
        
        XCTAssertEqual(localSource.getArticlesFromLocal().count - count, 0)
        
    }
    
    func testIsFavourite() {
        localSource.addFav(article: article)
        XCTAssertTrue(localSource.isFavourite(title: article.title))
        localSource.deleteFromLocal(article: article)
        XCTAssertEqual(localSource.getArticlesFromLocal().count, 0)
    }
    
}
