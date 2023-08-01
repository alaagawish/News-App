//
//  NetworkTests.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import XCTest
@testable import News_App

final class NetworkTests: XCTestCase {
    
    var network: NetworkProtocol!
    override func setUpWithError() throws {
        
        network = Network()
    }
    
    override func tearDownWithError() throws {
        
        network = nil
    }
    
    func testGetData() {
        
        let myExpectation = expectation(description: "network")
        network.getData(path: "", parameters: ["":""], handler: { result in
            guard result != nil else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
            XCTAssertNotNil(result?.status)
            myExpectation.fulfill()
        })
        waitForExpectations(timeout: 10)
    }
    
}
