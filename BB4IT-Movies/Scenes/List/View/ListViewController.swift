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

// MARK: Setup UICollection Delegate and DataSource
extension ListViewController: CollectionViewConfig {
    
    func setCollectionView() {
        [categoriesCollectionView, moviesCollectionView].forEach { $0?.delegate = self }
        [categoriesCollectionView, moviesCollectionView].forEach { $0?.dataSource = self }
        categoriesCollectionView.registerCell(cellClass: CategoryCollectionViewCell.self)
        moviesCollectionView.registerCell(cellClass: MovieCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoriesCollectionView:
            viewModel.categoriesData.count
        default:
            viewModel.numberOfMoviesRow
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoriesCollectionView:
            let cell = collectionView.dequeue(with: CategoryCollectionViewCell.self, for: indexPath)
            cell.configureCell(data: viewModel.categoriesData[indexPath.row])
            return cell
        default:
            let cell = collectionView.dequeue(with: MovieCollectionViewCell.self, for: indexPath)
            cell.configureCell(data: viewModel.cellMoviesData(index: indexPath.row))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoriesCollectionView:
            viewModel.selectedCategoryData(index: indexPath.row)
        default:
            break
        }
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case categoriesCollectionView:
            CGSize(width: categoriesCollectionView.frame.width / 3, height: 40)
        default:
            CGSize(width: moviesCollectionView.frame.width, height: moviesCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK: UI BIND
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
            [categoriesCollectionView, moviesCollectionView].forEach { $0?.reloadData() }
            if viewModel.numberOfMoviesRow != 0 {
                moviesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
        }.store(in: &cancellable)
    }
    
    func bindIndicator() {
        viewModel.$isLoading.sink { [weak self] start in
            guard let self else { return }
            start ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }.store(in: &cancellable)
    }
    
    func bindShowOkAlert() {
        viewModel.$showAlert.sink { [weak self] text in
            guard let self, let text else { return }
            self.makeOkAlert(title: text)
        }.store(in: &cancellable)
    }
}
