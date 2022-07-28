//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Alex Kulish on 28.07.2022.
//

import UIKit
import Combine

class NewsDetailsViewController: UIViewController {
    
    private lazy var categoryTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var fullUrlLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [categoryTypeLabel, descriptionLabel, fullUrlLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private var anyCancellables = Set<AnyCancellable>()
    
    var news = PassthroughSubject<News, Never>()
//    var news2: News!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
//        configure()
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(newsImageView)
    }
    
//    func configure() {
//        categoryTypeLabel.text = news2.categoryType
//        descriptionLabel.text = news2.description
//        fullUrlLabel.text = news2.fullUrl
//
//        guard let url = URL(string: news2.titleImageUrl) else { return }
//
//        DispatchQueue.global().async {
//            guard let imageData = try? Data(contentsOf: url) else { return }
//
//            DispatchQueue.main.async {
//                self.newsImageView.image = UIImage(data: imageData)
//            }
//        }
//    }
    
    private func configure() {
        news
            .sink { [weak self] news in
                self?.categoryTypeLabel.text = news.categoryType
                self?.descriptionLabel.text = news.description
                self?.fullUrlLabel.text = news.fullUrl
                
                guard let url = URL(string: news.titleImageUrl) else { return }
                
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: url) else { return }
                    
                    DispatchQueue.main.async {
                        self?.newsImageView.image = UIImage(data: imageData)
                    }
                }
            }
            .store(in: &anyCancellables)
    }
    
}

extension NewsDetailsViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            newsImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
}
