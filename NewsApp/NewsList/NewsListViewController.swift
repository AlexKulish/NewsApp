//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Alex Kulish on 27.07.2022.
//

import UIKit
import Combine

class NewsListViewController: UIViewController {
    
    // MARK: - Private properties

    private var viewModel = NewsListViewModel()
    private var anyCancellables = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Lyfecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        fetchNews()
        setupNavigationBar()
    }
    
    // MARK: - Private methods

    private func fetchNews() {
        viewModel.fetchNews()
        viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &anyCancellables)
    }
    
    private func setupNavigationBar() {
        title = "News"
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension NewsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        viewModel.$news
            .receive(on: DispatchQueue.main)
            .sink { _ in
                cell.viewModel = self.viewModel.setupCellViewModel(at: indexPath)
            }
            .store(in: &anyCancellables)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsDetailsVC = NewsDetailsViewController()
        newsDetailsVC.viewModel = self.viewModel.setupDetailsViewModel(at: indexPath)
        navigationController?.pushViewController(newsDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5

        UIView.animate(withDuration: 1) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: - Create Compositional Layout

extension NewsListViewController {
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            
            let edgeInset: CGFloat = 8
            let zeroEdgeInset: CGFloat = 0
            let countItemsInGroup = 2
            let fractional: CGFloat = 1
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractional), heightDimension: .fractionalHeight(fractional))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: edgeInset, leading: zeroEdgeInset, bottom: edgeInset, trailing: zeroEdgeInset)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fractional), heightDimension: .fractionalHeight(0.8))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: countItemsInGroup)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: zeroEdgeInset, leading: edgeInset, bottom: zeroEdgeInset, trailing: edgeInset)
            
            return section
            
        }
        return layout
    }
}
