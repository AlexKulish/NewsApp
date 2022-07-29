//
//  News.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation

struct NewsModel: Codable {
    let news: [News]
}

struct News: Codable {
    let title: String
    let description: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String
}
