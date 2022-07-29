//
//  NewsListViewModel.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation
import Combine

class NewsListViewModel {
    
    @Published var news: [News] = []
    
    init() {}
    
    func fetchNews() {
        Task {
            do {
                news = try await NetworkManager.shared.fetchNews().news
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func setupCellViewModel(at indexPath: IndexPath) -> NewsCellViewModelProtocol {
        let news = news[indexPath.item]
        return NewsCellViewModel(news: news, numberOfPage: indexPath.item)
    }
    
    func setupDetailsViewModel(at indexPath: IndexPath) -> NewsDetailsViewModelProtocol {
        let news = news[indexPath.item]
        return NewsDetailsViewModel(news: news)
    }
    
}
