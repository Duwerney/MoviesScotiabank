//
//  MovieDetail.swift
//  MovieScotiabank
//
//  Created by user on 19/05/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let posterPath = movie.posterPath {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 300)
                    }
                }
                
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    IconLabelView(iconName: "star.fill", text: String(format: "%.1f", movie.voteAverage))
                        .foregroundColor(.yellow)
                    Spacer()
                    Text("Votes: \(movie.voteCount)")
                        .font(.subheadline)
                }
                
                Text("Language: \(movie.originalLanguage)")
                    .font(.subheadline)
                
                if movie.adult {
                    Text("Adult")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .bold()
                }
                
                Text(movie.overview)
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
