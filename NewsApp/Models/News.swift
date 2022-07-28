//
//  News.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation

struct NewsModel: Decodable {
    let news: [News]
//    let totalCount: Int
}

struct News: Decodable {
//    let id: Int
    let title: String
    let description: String
    let publishedDate: String
//    let url: String
    let fullUrl: String
    let titleImageUrl: String
    let categoryType: String

}
