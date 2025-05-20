//
//  ListViewModel.swift
//  BB4IT-Movies
//
//  Created by Donia Elshenawy on 19/05/2025.
//

import Foundation

final class ListViewModel {
    
    @Published var indexSelectedCategory: Int?
    @Published var reloadViews = false
    @Published var isLoading = false
    @Published var showAlert: String?
    
    private let network: NetworkProtocol = NetworkManager()
    private var moviesData: MoviesResponse?
        
    private var categoriesData = [
        CategoriesModel(title: "Now Playing", keypath: "now_playing"),
        CategoriesModel(title: "Popular", keypath: "popular"),
        CategoriesModel(title: "Upcoming", keypath: "upcoming")
    ]
    
    func setCategoryData() {
        categoriesData.forEach { $0.isSelected = false }
        categoriesData.first?.isSelected = true
        getMoviesDataRequest(type: categoriesData.first?.keypath ?? "")
    }
}

// MARK: Get Data From API
private extension ListViewModel {
    func getMoviesDataRequest(type: String) {
        isLoading = true
        let request = AppEndPoints.getMovies(type)
        network.fetchData(endPoint: request, response: MoviesResponse.self) { [weak self] result in
            guard let self else { return }
            isLoading = false
            switch result {
            case .success(let data):
                moviesData = data
                reloadViews = true
            case .failure(let error):
                showAlert = error.localizedDescription
            }
        }
    }
}

extension ListViewModel {
    var numberOfMovies: Int {
        moviesData?.results?.count ?? 0
    }
    
    func cellMoviesData(index: Int) -> MovieResponse? {
        moviesData?.results?[index]
    }
}

extension ListViewModel {
    var numberOfCategories: Int {
        categoriesData.count
    }
    
    func categoriesCellData(index: Int) -> CategoriesModel {
        categoriesData[index]
    }
    
    func selectCategory(index: Int) {
        categoriesData.forEach { $0.isSelected = false }
        categoriesData[index].isSelected = true
        indexSelectedCategory = index
        getMoviesDataRequest(type: categoriesData[index].keypath)
    }
}
