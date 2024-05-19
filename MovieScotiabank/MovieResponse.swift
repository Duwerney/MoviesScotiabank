//
//  MovieResponse.swift
//  MovieScotiabank
//
//  Created by user on 18/05/24.
//

import Foundation


struct MovieResponse: Decodable {
    let results: [Movie]
}
