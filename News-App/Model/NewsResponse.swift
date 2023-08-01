//
//  NewsResponse.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation

struct NewsResponse: Decodable{
    let status: String?
    let totalResult: Int?
    let articles: [Article]?
}
