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
    private var anyCancellable = Set<AnyCancellable>()
    
    
}
