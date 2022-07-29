//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by Alex Kulish on 28.07.2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    //MARK: - Public properties
    
    var viewModel: NewsDetailsViewModelProtocol? {
        didSet {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
            fullUrlLabel.text = viewModel?.fullUrl
            guard let imageData = viewModel?.imageData else { return }
            newsImageView.image = UIImage(data: imageData)
        }
    }
    
    // MARK: - Private properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
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
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, fullUrlLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
        
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
    
}

extension NewsDetailsViewController {
    
    // MARK: - Add subviews
    
    private func addSubviews() {
        view.addSubview(stackView)
        view.addSubview(newsImageView)
    }
    
    // MARK: - Setup constraints
    
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
