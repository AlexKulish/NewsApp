//
//  NewsCell.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    // MARK: - Public properties
    
    static let identifier = "NewsCell"
    
    var viewModel: NewsCellViewModelProtocol? {
        didSet {
            newsDescriptionLabel.text = viewModel?.title
            numberOfPageLabel.text = viewModel?.numberOfPage
            guard let imageData = viewModel?.imageData else { return }
            newsImageView.image = UIImage(data: imageData)
            activityIndicator?.stopAnimating()
        }
    }
    
    // MARK: - Private properties
    
    private var activityIndicator: UIActivityIndicatorView?
    
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
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        activityIndicator = showActivityIndicator(in: self)
        backgroundColor = .white
        layer.borderWidth = 0.5
        layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        layer.cornerRadius = 15
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showActivityIndicator(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        addSubview(activityIndicator)
        
        return activityIndicator
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
        
        let leadingTrailingConstant: CGFloat = 32
        let topBottomConstant: CGFloat = 16
        
        NSLayoutConstraint.activate([
            newsDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingTrailingConstant),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -leadingTrailingConstant),
            newsDescriptionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomConstant)
        ])
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: topBottomConstant),
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
