//
//  ListViewController.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import UIKit

final class ListViewController: BaseViewController {

    @IBOutlet private weak var moviesCollectionView: UICollectionView!
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    
    private let viewModel = ListViewModel()
    private var collectionViews: [UICollectionView] {
        [moviesCollectionView, categoriesCollectionView]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        isNavigationHidden(true)
        setCollectionView()
        bindUI()
        viewModel.setCategoryData()
    }
}

private extension ListViewController {
    
    func isMoviesCollectionView(_ collectionView: UICollectionView) -> Bool {
        collectionView == moviesCollectionView
    }
    
    func setCollectionView() {
        collectionViews.forEach {
            $0.delegate = self
            $0.dataSource = self
        }
        categoriesCollectionView.registerCell(cellClass: CategoryCollectionViewCell.self)
        moviesCollectionView.registerCell(cellClass: MovieCollectionViewCell.self)
    }
}

// MARK: Setup UICollection Delegate and DataSource
extension ListViewController: CollectionViewConfig {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isMoviesCollectionView(collectionView) ? viewModel.numberOfMovies : viewModel.numberOfCategories
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        isMoviesCollectionView(collectionView) ? setUpMoviesCollectionView(for: indexPath) : setUpCategoriesCollectionView(for: indexPath)
    }
    
    private func setUpCategoriesCollectionView(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeue(with: CategoryCollectionViewCell.self, for: indexPath)
        cell.configureCell(data: viewModel.categoriesCellData(index: indexPath.row))
        return cell
    }
    
    private func setUpMoviesCollectionView(for indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeue(with: MovieCollectionViewCell.self, for: indexPath)
        cell.configureCell(data: viewModel.cellMoviesData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isMoviesCollectionView(collectionView) ?
        push(MovieDetailsViewController(movieId: viewModel.cellMoviesData(index: indexPath.row)?.id ?? 0)) :
        viewModel.selectCategory(index: indexPath.row)
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        isMoviesCollectionView(collectionView) ?
        CGSize(width: moviesCollectionView.frame.width, height: moviesCollectionView.frame.height) :
        CGSize(width: categoriesCollectionView.frame.width / 3, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: Bind UI
private extension ListViewController {
    
    func bindUI() {
        bindReloadViews()
        bindIsSelectedCategories()
        bindIndicator()
        bindShowOkAlert()
    }
    
    func bindIsSelectedCategories() {
        viewModel.$indexSelectedCategory.sink { [weak self] index in
            guard let self, index != nil else { return }
            categoriesCollectionView.reloadData()
            categoriesCollectionView.scrollToItem(at: IndexPath(row: index ?? 0, section: 0), at: .centeredHorizontally, animated: true)
        }.store(in: &cancellable)
    }
    
    func bindReloadViews() {
        viewModel.$reloadViews.sink { [weak self] reload in
            guard let self, reload else { return }
            collectionViews.forEach { $0.reloadData() }
            guard viewModel.numberOfMovies > 0 else { return }
            moviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
        }.store(in: &cancellable)
    }
    
    func bindIndicator() {
        viewModel.$isLoading.sink { [weak self] start in
            guard let self else { return }
            start ? startLoading() : stopLoading()
        }.store(in: &cancellable)
    }
    
    func bindShowOkAlert() {
        viewModel.$showAlert.sink { [weak self] text in
            guard let self, let text else { return }
            makeOkAlert(title: text)
        }.store(in: &cancellable)
    }
}
