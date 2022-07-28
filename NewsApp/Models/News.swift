//
//  News.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation

struct NewsModel: Decodable {
    let news: [News]
}

struct News: Decodable {
    let title: String
    let description: String
    let publishedDate: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String
}
