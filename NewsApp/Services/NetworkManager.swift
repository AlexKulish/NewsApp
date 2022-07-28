//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchNews() async throws -> NewsModel {

        let urlString = "https://webapi.autodoc.ru/api/news/1/15"
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidUrl
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()

        guard let news = try? decoder.decode(NewsModel.self, from: data) else {
            throw NetworkError.decodingError
        }

        return news
    }
    
}

enum NetworkError: Error {
    case invalidUrl
    case noData
    case decodingError
}
