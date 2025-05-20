//
//  MovieDetailsViewController.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 20/05/2025.
//

import UIKit

final class MovieDetailsViewController: BaseViewController {

    @IBOutlet private weak var genresCollectionView: UICollectionView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var movieNameLabel: UILabel!
    @IBOutlet private weak var movieImage: UIImageView!
    
    private let movieId: Int
    private lazy var viewModel = MovieDetailsViewModel(movieId: movieId)
    
    init(movieId: Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        isNavigationHidden(false)
        setCollectionView()
        bindUI()
        viewModel.getMoviesDetailsRequest()
    }
}

// MARK: Setup UICollection Delegate and DataSource
extension MovieDetailsViewController: CollectionViewConfig {
    
    private func setCollectionView() {
        genresCollectionView.delegate = self
        genresCollectionView.dataSource = self
        genresCollectionView.registerCell(cellClass: CategoryCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfGenres
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(with: CategoryCollectionViewCell.self, for: indexPath)
        cell.configureGenreCell(data: viewModel.cellGenresData(index: indexPath.row))
        return cell
    }
}

extension MovieDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: genresCollectionView.frame.width / 3, height: 40)
    }
}

// MARK: Bind UI
private extension MovieDetailsViewController {
    
    func bindUI() {
        bindIndicator()
        bindShowOkAlert()
        bindGetMovieData()
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
    
    func bindGetMovieData() {
        viewModel.$movieData.sink { [weak self] movie in
            guard let self, let movie else { return }
            setMovieData(movie)
        }.store(in: &cancellable)
    }
    
    private func setMovieData(_ movie: MovieDetailsResponse?) {
        movieNameLabel.text = movie?.title ?? ""
        releaseDateLabel.text = movie?.releaseDate ?? ""
        overviewLabel.text = movie?.overview ?? ""
        movieImage.loadTMDbImage(from: movie?.posterPath)
        genresCollectionView.reloadData()
    }
}
