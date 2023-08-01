//
//  DetailsViewModelTests.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import XCTest
@testable import News_App

final class DetailsViewModelTests: XCTestCase {

    var detailsViewModel: DetailsViewModel!
    var localSource: LocalSourceProtocol!
    let article = Article(source: Source(id: "id", name: "name"), author: "author", title: "title", description: "description", url: "url", urlToImage: "urlImage", publishedAt: "date", content: "content")
   
    override func setUpWithError() throws {
    
        localSource = MockLocalSource()
        detailsViewModel = DetailsViewModel(localSource: localSource)
    }

    override func tearDownWithError() throws {
        detailsViewModel = nil
        localSource = nil
    }

    
    func testCheckFav() {
        
        detailsViewModel.addToFav(article: article)
        XCTAssertTrue(detailsViewModel.checkFav(article: article))
    }
    func testAddToFav() {
        XCTAssertFalse(detailsViewModel.checkFav(article: article))
        detailsViewModel.addToFav(article: article)
        XCTAssertTrue(detailsViewModel.checkFav(article: article))
    }
    func testRemoveFromFav() {
        detailsViewModel.addToFav(article: article)
        XCTAssertTrue(detailsViewModel.checkFav(article: article))
        detailsViewModel.removeFromFav(article: article)
        XCTAssertFalse(detailsViewModel.checkFav(article: article))
    }

}
