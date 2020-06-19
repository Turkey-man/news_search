//
//  Article.swift
//  NewsSearch
//
//  Created by ****** ****** on 17.06.2020.
//  Copyright © 2020 ****** ******. All rights reserved.
//

import Foundation

struct Articles: Codable {
    var articles: [Article]?
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    let source: Source?
}

struct Source: Codable {
    let id: String?
    let name: String?
}
