//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation
import Combine

class NewsViewModel {
    
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
    
    
}
