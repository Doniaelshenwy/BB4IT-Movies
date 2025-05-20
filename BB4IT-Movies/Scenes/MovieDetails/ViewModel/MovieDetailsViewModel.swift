//
//  MovieDetailsViewModel.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 20/05/2025.
//

import Foundation

final class MovieDetailsViewModel {
    
    @Published var isLoading = false
    @Published var showAlert: String?
    @Published var movieData: MovieDetailsResponse?
    
    private let network: NetworkProtocol = NetworkManager()
    private var movieDetails: MovieDetailsResponse?
    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
        
    func getMoviesDetailsRequest() {
        isLoading = true
        let request = AppEndPoints.getMovieDetails(movieId)
        network.fetchData(endPoint: request, response: MovieDetailsResponse.self) { [weak self] result in
            guard let self else { return }
            isLoading = false
            switch result {
            case .success(let data):
                movieDetails = data
                movieData = data
            case .failure(let error):
                showAlert = error.localizedDescription
            }
        }
    }
}

extension MovieDetailsViewModel {
    var numberOfGenres: Int {
        movieDetails?.genres?.count ?? 0
    }
    
    func cellGenresData(index: Int) -> GenreResponse? {
        movieDetails?.genres?[index]
    }
}
