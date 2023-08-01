//
//  Article.swift
//  News-App
//
//  Created by Alaa on 01/08/2023.
//

import Foundation

struct Article: Decodable{
    let source: Source
    let author: String?
    let title, description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String
}
