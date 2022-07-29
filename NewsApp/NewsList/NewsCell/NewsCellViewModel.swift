//
//  NewsCellViewModel.swift
//  NewsApp
//
//  Created by Alex Kulish on 29.07.2022.
//

import Foundation

protocol NewsCellViewModelProtocol {
    var title: String { get }
    var imageData: Data? { get }
    var numberOfPage: String { get set }
    init(news: News, numberOfPage: Int)
}

class NewsCellViewModel: NewsCellViewModelProtocol {
    
    var title: String {
        news.title
    }
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: news.titleImageUrl)
    }
    
    var numberOfPage: String
    
    private let news: News
    
    required init(news: News, numberOfPage: Int) {
        self.news = news
        self.numberOfPage = String(numberOfPage + 1)
    }
    
}
