//
//  MockAPIFileLoader.swift
//  News-AppTests
//
//  Created by Alaa on 01/08/2023.
//

import Foundation
@testable import News_App

class MockAPIFileLoader {
    
    func loadApiFiles() -> NewsResponse? {
        let bundle = Bundle(for: type(of: self))
        let fileUrl =  bundle.url(forResource: "MockResponse", withExtension: "json")
        do {
            let data = try Data(contentsOf: fileUrl!)
            let response = try JSONDecoder().decode(NewsResponse.self, from: data)
            return response
        } catch {
            return nil
        }
    }
    
    
    private func generateModel(for path: String) -> NewsResponse? {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let mockyJSON = try? JSONDecoder().decode(NewsResponse.self, from: data)
        else { return nil }
        return mockyJSON
    }
    
}

