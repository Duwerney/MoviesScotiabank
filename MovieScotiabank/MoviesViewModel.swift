//
//  MoviesViewModel.swift
//  MovieScotiabank
//
//  Created by user on 18/05/24.
//

import Combine
import SwiftUI

public class MoviesViewModel: ObservableObject {
    @Published var popularMovies: [Movie] = []
    @Published var topMovies: [Movie] = []
    @Published var filteredPopularMovies: [Movie] = []
    @Published var filteredTopMovies: [Movie] = []
    @Published var adultFilter: Bool = false
    @Published var voteAverage: String = ""
    @Published var languageFilter: String = "en"
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var searchQuery: String = ""
    @Published var searchResults: [Movie] = []
    
    
    private var cancellables = Set<AnyCancellable>()
    public let searchSubject = PassthroughSubject<String, Never>()
    
    
    private var languageMap: [String: String] = [
        "en": "en",
        "english": "en",
        "ingles": "en",
        "Ingles": "en",
        "es": "es",
        "spanish": "es",
        "español": "es",
        "Español": "es",
        "fr": "fr",
        "Frances": "fr",
        "ko": "kr",
        "Koreano": "kr",
        "zh": "zh"
    ]
    
    init() {
        searchBar()
    }
    
    func fetchMovies() {
        FilterPopular()
        FilterTop()
    }
    
    func searchMovies(query: String) {
        print(query)
        
        if (query.isEmpty){
            filteredPopularMovies = popularMovies.filter { $0.originalLanguage == languageFilter}
            filteredTopMovies = topMovies.filter { $0.originalLanguage == languageFilter}
        } else {
            filteredPopularMovies = popularMovies.filter { $0.title.lowercased().contains(query.lowercased()) && $0.originalLanguage == languageFilter }
            filteredTopMovies = topMovies.filter { $0.title.lowercased().contains(query.lowercased()) && $0.originalLanguage == languageFilter }
        }
    }
    
   
    
    func filterMovies() {
        
        var newFilteredPopularMovies = popularMovies
        var newFilteredTopMovies = topMovies
        
        languageFilter(&newFilteredPopularMovies, &newFilteredTopMovies)
        adultFilter(&newFilteredPopularMovies, &newFilteredTopMovies)
        voteAverageFilter(&newFilteredPopularMovies, &newFilteredTopMovies)
        alertFilter(newFilteredPopularMovies, newFilteredTopMovies)
        
        filteredPopularMovies = newFilteredPopularMovies
        filteredTopMovies = newFilteredTopMovies

    }

    
    private func showAlert(message: String) {
        self.alertMessage = message
        self.showAlert = true
    }
    
    
    
    fileprivate func adultFilter(_ newFilteredPopularMovies: inout [Movie], _ newFilteredTopMovies: inout [Movie]) {
        if adultFilter {
            newFilteredPopularMovies = newFilteredPopularMovies.filter { !$0.adult }
            newFilteredTopMovies = newFilteredTopMovies.filter { !$0.adult }
        }
    }
    
    fileprivate func languageFilter(_ newFilteredPopularMovies: inout [Movie], _ newFilteredTopMovies: inout [Movie]) {
        if !languageFilter.isEmpty {
            let normalizedLanguage = languageFilter.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
            let languageCode = languageMap[normalizedLanguage] ?? normalizedLanguage
            
            
            newFilteredPopularMovies = newFilteredPopularMovies.filter { $0.originalLanguage == languageCode }
            newFilteredTopMovies = newFilteredTopMovies.filter { $0.originalLanguage == languageCode }
            
        }
    }
    
    fileprivate func voteAverageFilter(_ newFilteredPopularMovies: inout [Movie], _ newFilteredTopMovies: inout [Movie]) {
        if let voteAverageDouble =  Double(voteAverage) {
            newFilteredPopularMovies = newFilteredPopularMovies.filter { $0.voteAverage >= voteAverageDouble }
        } else {
            print("Error: No se pudo convertir \(voteAverage) a Double")
        }
        
        if let voteAverageDouble =  Double(voteAverage) {
            newFilteredTopMovies = newFilteredTopMovies.filter { $0.voteAverage >= voteAverageDouble }
        } else {
            print("Error: No se pudo convertir \(voteAverage) a Double")
        }
    }
    
    fileprivate func alertFilter(_ newFilteredPopularMovies: [Movie], _ newFilteredTopMovies: [Movie]) {
        if newFilteredPopularMovies.isEmpty && newFilteredTopMovies.isEmpty {
            showAlert(message: "No movies found for the selected filters.")
            
        }
    }
    
    fileprivate func FilterPopular() {
        MovieService.shared.fetchMovies(category: "popular") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieResponse):
                    self.popularMovies = movieResponse.results
                    self.filteredPopularMovies =  self.popularMovies
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    
    fileprivate func FilterTop() {
        MovieService.shared.fetchMovies(category: "top_rated") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieResponse):
                    self.topMovies = movieResponse.results
                    self.filteredTopMovies = self.topMovies
                case .failure(let error):
                    self.showAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    fileprivate func searchBar() {
        searchSubject
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchMovies(query: query)
            }
            .store(in: &cancellables)
    }
}


