//
//  NewsCell.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let identifier = "NewsCell"
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var newsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News) {
//        newsImageView.image = UIImage(named: news.titleImageUrl)
        newsDescriptionLabel.text = news.title
        
        guard let url = URL(string: news.titleImageUrl) else { return }

        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else { return }

            DispatchQueue.main.async {
                self.newsImageView.image = UIImage(data: imageData)
            }
        }
        
    }
}

extension NewsCell {
    
    private func addSubviews() {
        addSubview(newsImageView)
        addSubview(newsDescriptionLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            newsDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}
