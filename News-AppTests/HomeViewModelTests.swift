//
//  HomeViewModelTests.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import XCTest
@testable import News_App

final class HomeViewModelTests: XCTestCase {
    
    var network: NetworkProtocol!
    var homeViewModel: HomeViewModel!
    var localSource: LocalSourceProtocol!
    override func setUpWithError() throws {
        network = MockNetwork(isSuccess: true)
        localSource = MockLocalSource()
        homeViewModel = HomeViewModel(network: network, localSource: localSource)
    }
    
    override func tearDownWithError() throws {
        homeViewModel = nil
        network = nil
        localSource = nil
    }
    
    func testGetData(){
        homeViewModel.getData()
        XCTAssertNotNil(homeViewModel.articles)
        
    }
    func testSaveArticlesLocal() {
        homeViewModel.saveArticlesLocal()
        XCTAssertNotNil(homeViewModel.getSavedArticles())
        
    }
    func testGetSavedArticles() {
        XCTAssertNotNil(homeViewModel.getSavedArticles())
    }
    
    func testDeleteAll() {
        homeViewModel.deleteAll()
        XCTAssertEqual(homeViewModel.getSavedArticles().count, 0)
        
    }
}
