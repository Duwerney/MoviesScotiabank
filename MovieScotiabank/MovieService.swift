//
//  MovieService.swift
//  MovieScotiabank
//
//  Created by user on 17/05/24.
//

import Foundation

class MovieService {
    public static let shared = MovieService()
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    private let apiKey = "1e319a87c6892cfeef69bdf1e18d70d0"
    private let baseURL = "https://api.themoviedb.org/3"
    private var session: URLSession
    
    
    func fetchMovies(category: String, completion: @escaping (Result<MovieResponse, MovieError>) -> Void) {
        let urlString = "\(baseURL)/movie/\(category)?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(movieResponse))
            } catch {
                completion(.failure(.serializationError))
            }
        }.resume()
    }
}



