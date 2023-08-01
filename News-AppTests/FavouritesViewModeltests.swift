//
//  FavouritesViewModeltests.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import XCTest
@testable import News_App

final class FavouritesViewModeltests: XCTestCase {
    
    var favouritesViewModel: FavouritesViewModel!
    var localSource: LocalSourceProtocol!
    
    let article = LocalArticle(author: "author", source: LocalSource(id: "id", name: "name"), title: "title", description: "description", url: "url", urlToImage: "urlImage", content: "content", publishedAt: "date", isFav: false)
    override func setUpWithError() throws {
        localSource = MockLocalSource()
        favouritesViewModel = FavouritesViewModel(localSource: localSource)
    }
    
    override func tearDownWithError() throws {
        favouritesViewModel = nil
        localSource = nil
    }
    
    func testGetArticles() {
        favouritesViewModel.getArticles()
        XCTAssertNotNil(favouritesViewModel.articles?.count)
        
        
    }
    
    func testDeleteArticle(){
        localSource.insertArticle(article: article)
        favouritesViewModel.deleteArticle(article: article)
        favouritesViewModel.getArticles()
        XCTAssertEqual(favouritesViewModel.articles?.count, 0)
    }
    
    func testGetSelectedArticle() {
        localSource.addFav(article: article)
        XCTAssertNotNil(favouritesViewModel.getSelectedArticle(title: article.title))
        
    }
    
    func testGetFavouriteArticles() {
        localSource.addFav(article: article)
        XCTAssertNotNil(favouritesViewModel.getFavouriteArticles())
        
    }
    
}
