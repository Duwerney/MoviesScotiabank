//
//  Movie.swift
//  MovieScotiabank
//
//  Created by user on 17/05/24.
//

import Foundation


struct Movie : Decodable, Identifiable , Hashable{
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let posterPath: String?
    let adult: Bool
    let originalLanguage: String
    

    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, adult
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
    }
}
