//
//  NewsCell.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    static let identifier = "NewsCell"
    
    var viewModel: NewsCellViewModelProtocol? {
        didSet {
            newsDescriptionLabel.text = viewModel?.title
            numberOfPageLabel.text = viewModel?.numberOfPage
            guard let imageData = viewModel?.imageData else { return }
            newsImageView.image = UIImage(data: imageData)
        }
    }
    
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
    
    private lazy var numberOfPageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemGray
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
    
}

extension NewsCell {
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        addSubview(newsImageView)
        addSubview(newsDescriptionLabel)
        addSubview(numberOfPageLabel)
    }
    
    // MARK: - Setup constraints
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            newsDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 16),
            newsImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            numberOfPageLabel.topAnchor.constraint(equalTo: newsDescriptionLabel.topAnchor),
            numberOfPageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            numberOfPageLabel.leadingAnchor.constraint(equalTo: newsDescriptionLabel.trailingAnchor)
        ])
        
    }
    
}
