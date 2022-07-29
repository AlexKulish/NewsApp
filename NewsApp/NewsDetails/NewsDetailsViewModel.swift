//
//  NewsDetailsViewModel.swift
//  NewsApp
//
//  Created by Alex Kulish on 29.07.2022.
//

import Foundation

// MARK: - NewsDetailsViewModelProtocol

protocol NewsDetailsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var fullUrl: String { get }
    var imageData: Data? { get }
    init(news: News)
}

// MARK: - NewsDetailsViewModel

class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    
    var title: String {
        news.title
    }
    
    var description: String {
        news.description
    }
    
    var fullUrl: String {
        "Ссылка: \(news.fullUrl)"
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: news.titleImageUrl)
    }
    
    private let news: News
    
    required init(news: News) {
        self.news = news
    }
    
}
